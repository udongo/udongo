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

    %w(title keywords description custom slug).each do |f|
      self.send("seo_#{f}=", @seo.send(f))
    end
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

    %w(title keywords description custom slug).each do |f|
      self.send("seo_#{f}=", params["seo_#{f}".to_sym])
    end

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

    %w(title keywords description custom slug).each do |f|
      @seo.send("#{f}=", send("seo_#{f}"))
    end

    # Saves the page, translation and SEO info all at once.
    @seo.save!
    @page.save!
  end
end
