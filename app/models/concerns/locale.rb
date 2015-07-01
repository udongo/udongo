# This concern is applicable when your model has a 'locale' field.
module Concerns
  module Locale
    extend ActiveSupport::Concern

    included do
      scope :by_locale, ->(l) { where(locale: l) }
    end
  end
end
