module Udongo::Search
  class Term
    attr_reader :controller, :string

    def initialize(string, controller: nil)
      @string = string
      @controller = controller
    end

    def locale
      return controller.locale if controller.present?
      Udongo.config.i18n.app.default_locale.to_sym
    end

    # TODO: How strict should we be when looking for synonyms? Should one have
    # to type the full synonym before we get a match? Right now, the code
    # performs a strict matching. A non-strict match needs the following LIKE
    # clause: ",%#{string}%," instead of "%,#{string},%".
    #
    # Example: A synonym "My new search" that already gets matched after
    # entering "My new"
    def synonym
      SearchSynonym.where(locale: locale)
        .where('concat(",", synonyms, ",") LIKE ?', "%,#{string},%")
        .take
    end

    def value
      return synonym.term if synonym
      string
    end
  end
end
