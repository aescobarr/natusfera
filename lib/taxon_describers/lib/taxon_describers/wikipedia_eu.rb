require ::File.expand_path('../wikipedia', __FILE__)
module TaxonDescribers

  class WikipediaEu < Wikipedia
    def wikipedia
      @wikipedia ||= WikipediaService.new(:locale => "eu")
    end

    def self.describer_name
      "Wikipedia (EU)"
    end

    def page_url(taxon)
      "http://eu.wikipedia.org/wiki/#{taxon.wikipedia_title || taxon.name}"
    end
  end

end