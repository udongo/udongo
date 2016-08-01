class Backend::PageTranslationForm < Udongo::Form
  attr_reader :page, :translation, :seo

  attribute :title, String
  attribute :subtitle, String

  attribute :seo_title, String
  attribute :seo_keywords, String
  attribute :seo_description, String
  attribute :seo_custom, String
  attribute :seo_slug, String

  validates :title, :seo_slug, presence: true

  delegate :id, to: :page

  def initialize(page, translation, seo)
    @page = page
    @translation = translation
    @seo = seo

    self.title = @translation.title
    self.subtitle = @translation.subtitle

    self.seo_title = @seo.title
    self.seo_keywords = @seo.keywords
    self.seo_description = @seo.description
    self.seo_custom = @seo.custom
    self.seo_slug = @seo.slug
  end

  def self.model_name
    Page.model_name
  end

  def persisted?
    true
  end

  def save(params)
    self.title = params[:title]
    self.subtitle = params[:subtitle]

    self.seo_title = params[:seo_title]
    self.seo_keywords = params[:seo_keywords]
    self.seo_description = params[:seo_description]
    self.seo_custom = params[:seo_custom]
    self.seo_slug = params[:seo_slug]

    if valid?
      save_object
      true
    else
      false
    end
  end

  private

  def save_object
    @translation.title = title
    @translation.subtitle = subtitle
    @translation.save

    @seo.title = seo_title
    @seo.keywords = seo_keywords
    @seo.description = seo_description
    @seo.custom = seo_custom
    @seo.slug = seo_slug
    @seo.save
  end
end
