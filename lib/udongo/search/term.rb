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

    def synonym
      SearchSynonym.where(locale: locale)
        .where('concat(",", synonyms, ",") LIKE ?', "%,#{string},%")
        .take
    end

    def valid?
      @string.present?
    end

    def value
      return synonym.term if synonym
      string
    end
  end
end
