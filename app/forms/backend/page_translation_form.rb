class Backend::PageTranslationForm < Reform::Form
  include Composition

  # model :page

  property :title, on: :translation
  property :subtitle, on: :translation

  property :seo_title, on: :seo
  property :seo_keywords, on: :seo
  property :seo_description, on: :seo
  property :seo_custom, on: :seo
  property :seo_slug, on: :seo

  validates :title, presence: true
  validates :seo_slug, presence: true
end

class Backend::PageTranslationForm < Udongo::Form
  attr_reader :page, :translation

  # attributes...

  # validations...

  delegate :id, to: :page

  def initialize(page, translation)
    @page = page
    @translation = translation

    init_attribute_values(translation)
  end

  def self.model_name
    Page.model_name
  end

  def persisted?
    true
  end

  private

  def save_object
    # set translation fields
    # set seo fields
    # save it
  end
end
