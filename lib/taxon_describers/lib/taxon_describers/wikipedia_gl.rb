require ::File.expand_path('../wikipedia', __FILE__)
module TaxonDescribers

  class WikipediaGl < Wikipedia
    def wikipedia
      @wikipedia ||= WikipediaService.new(:locale => "gl")
    end

    def self.describer_name
      "Wikipedia (GL)"
    end

    def page_url(taxon)
      "http://gl.wikipedia.org/wiki/#{taxon.wikipedia_title || taxon.name}"
    end
  end

end