class Backend::PageTranslationForm < Reform::Form
  include Composition

  model :page

  property :title, on: :translation
  property :subtitle, on: :translation

  property :seo_title, on: :seo
  property :seo_keywords, on: :seo
  property :seo_description, on: :seo
  property :seo_custom, on: :seo
  property :seo_slug, on: :seo

  validates :title, presence: true
  validates :seo_slug, presence: true # TODO only if necessary!
end
