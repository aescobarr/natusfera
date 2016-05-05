require ::File.expand_path('../wikipedia', __FILE__)
module TaxonDescribers

  class WikipediaCa < Wikipedia
    def wikipedia
      @wikipedia ||= WikipediaService.new(:locale => "ca")
    end

    def self.describer_name
      "Wikipedia (CA)"
    end

    def page_url(taxon)
      "http://ca.wikipedia.org/wiki/#{taxon.wikipedia_title || taxon.name}"
    end
  end

end