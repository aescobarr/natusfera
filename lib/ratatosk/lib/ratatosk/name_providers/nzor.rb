module Ratatosk
  module NameProviders
    #
    # Concrete strategy for getting names from NZOR
    #
    class NZORNameProvider
      def self.source
        @source ||= ::Source.find_by_title("New Zealand Organisms Register") || ::Source.create(
          :title => "New Zealand Organisms Register",
          :in_text => "New Zealand Organisms Register",
          :url => "http://www.nzor.org.nz",
          :citation => "New Zealand Organisms Register (2012). Accessible at http://www.nzor.org.nz."
        )
      end

      def initialize
        @service = NewZealandOrganismsRegister.new
      end

      def find(name)
        hxml = @service.search(:query => name)
        unless hxml.errors.blank?
          raise NameProviderError, "Failed to parse the response from the New Zealand Organisms Register"
        end
        #iterate over each of the search results building up a TaxonNameAdapter for each one.
        #this is different from what the catalogue of life seems to do
        hxml.at('Results').children.map do |r|
          NZORTaxonNameAdapter.new(r)
        end
      end

      #
      # Finds a taxon's ancestors from the name provider and returns an array
      # of them as *new* Taxon objects up until there is one already in our
      # database. Thus, the first Taxon in the array should either be a new
      # Kingdom or an existing saved Taxon that is already in our local tree.
      #
      def get_lineage_for(taxon)
        # If taxon was already fetched with classification data, use that
        #TODO use historically cached info
        if taxon.class != Taxon && taxon.hxml && taxon.hxml.at('ClassificationHierarchy')
          hxml = taxon.hxml
        else
          hxml = @service.get_taxon_for_nzor_id(:nzor_id => taxon.source_identifier)
        end
        lineage = [taxon] #don't put the taxon in there to begin with as it is a part of the classification hierarchy

        # walk UP the NZOR lineage creating new taxa
        hxml.at('ClassificationHierarchy').children.reverse_each do |ancestor_hxml|
          temp_taxon = NZORTaxonAdapter.new(ancestor_hxml)
          lineage << temp_taxon unless taxon.source_identifier == temp_taxon.source_identifier
        end
        lineage.compact
      end

      # Gets the phylum name for this taxon.
      def get_phylum_for(taxon, lineage = nil)
        #lineage should be an array of NZORTaxonAdapters - sorted species->kingdom
        lineage ||= get_lineage_for(taxon)
        phylum = lineage.select{|t| t.rank && t.rank.downcase == 'phylum'}.first
        phylum ||= lineage.last.phylum
        phylum
      end
    end
    class NZORTaxonNameAdapter
      include ModelAdapter
      attr_accessor :hxml
      alias :taxon_name :adaptee
      #
      # Initialize with a Nokogiri object of a single CoL XML response
      #
      def initialize(hxml, params = {})
        @adaptee = TaxonName.new(params)
        @service = NewZealandOrganismsRegister.new
        @hxml = hxml
        taxon_name.name = @hxml.at('PartialName').inner_text
        taxon_name.lexicon = get_lexicon
        taxon_name.is_valid = get_is_valid
        taxon_name.source = Source.find_by_title('New Zealand Organisms Register') rescue nil
        taxon_name.source_identifier = @hxml.at('NameId').inner_text
        taxon_name.source_url = 'http://data.nzor.org.nz/names/' + @hxml.at('NameId').inner_text
        taxon_name.taxon = taxon
        taxon_name.name_provider = "NZORNameProvider"
      end
      # Override taxon to make sure we always check to see if a taxon for this
      # name has been saved since the creation of this name's temporary taxon
      def taxon
        @taxon ||= get_taxon
      end
      # Overriden to make sure we always check to see if a taxon for this
      # name has been saved since the creation of this name's temporary taxon
      def save
        if taxon_name.taxon.nil? or taxon_name.taxon.new_record?
          taxon_name.taxon = taxon
        end
        taxon_name.save
      end
      protected

      #todo, check if it's always Scientific or English, and whether this has an effect'
      def get_lexicon
        if @hxml.at('Class').inner_text == 'Scientific Name'
          'Scientific Names'
        else
          'english'
        end
      end

      #
      # We assume that if the result has an accepted name and that the nameID
      # is equal to the nameID of the actual result then we are valid.
      #
      # TODO confirm that this assumption is correct .. should there only be one result?
      # does this also have to do with synonyms - need test data
      #
      # FROM ken-ichi
      # a)  returns true for Common (English / Vernacular) names.
      # b)  returns true for Scientific names _if_ they are the accepted name
      # c)  returns false if it's a Synonym for a scientific name.
      #
      def get_is_valid
        return true if is_comname?
        !@hxml.at('Name/AcceptedName/NameId').nil? &&  (@hxml.at('Name/AcceptedName/NameId').inner_text == @hxml.at('Name/NameId').inner_text)
      end

      #
      # Test if this is a common / vernacular name
      # #TODO check if this is a valid assumption
      #
      def is_comname?
        @hxml.at('Class').inner_text == 'Vernacular Name' || @hxml.at('Class').inner_text == 'English'
      end
      def is_sciname?
        @hxml.at('Class').inner_text == 'Scientific Name'
      end

      def get_taxon
        if is_sciname? and is_valid?
          taxon = NZORTaxonAdapter.new(@hxml)
        else
          taxon = NZORTaxonAdapter.new(accepted_name_hxml)
        end
        # This is necessary because calling save here runs the validations,
        # sees that the Taxon is new and declares the lexion validation ok,
        # then saves the new taxon, which would fire the after save callback
        # creating another taxon name, and then this taxon name gets
        # created, resulting in duplicate, invalid taxon names.
        taxon.skip_new_taxon_name = true

        taxon
      end

      #returns the xml for the accepted name related to this common/english/vernacular TaxonName
      def accepted_name_hxml
        #get the accepted (scientific) name for this taxon
        accepted_nzor_id = hxml.at('Concepts').at('ToConcept').at('NameId')
        unless accepted_nzor_id
          raise NameProviderError, "Failed to get a taxon for the common name from NZOR"
        end
        @service.get_taxon_for_nzor_id(:nzor_id => accepted_nzor_id.inner_text)
      end

    end
    class NZORTaxonAdapter
      include ModelAdapter
      attr_accessor :hxml
      alias :taxon :adaptee
      #
      # Initialize with a Nokogiri object of a single CoL XML response
      #
      def initialize(hxml, params = {})
        @hxml = hxml
        existing = Taxon.where(
          :source_id => ::Source.find_by_title('New Zealand Organisms Register').id,
          :source_identifier => @hxml.at('NameId').inner_text
        ).first rescue nil
        @adaptee = if existing.present?
          existing
        else
          Taxon.new(params)
        end

        @adaptee.name               = @hxml.at('PartialName').inner_text
        @adaptee.rank               = @hxml.at('Rank').inner_text.downcase
        @adaptee.source             = Source.find_by_title('New Zealand Organisms Register') rescue nil
        @adaptee.source_identifier  = @hxml.at('NameId').inner_text
        @adaptee.source_url         = 'http://data.nzor.org.nz/names/' + @hxml.at('NameId').inner_text
        @adaptee.name_provider      = "NZORNameProvider"
      end
    end
  end # module NameProviders
end # module Ratatosk
