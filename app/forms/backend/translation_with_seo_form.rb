class Backend::TranslationWithSeoForm < Udongo::Form
  attr_reader :model, :translation, :seo
  delegate :id, to: :model

  attribute :seo_title, String
  attribute :seo_keywords, String
  attribute :seo_description, String
  attribute :seo_custom_head, String
  attribute :seo_slug, String

  validates :seo_slug, :seo_title, :seo_description, presence: true

  def initialize(model, translation, seo)
    @model = model
    @translation = translation
    @seo = seo

    non_seo_attributes.each do |f|
      self.send "#{f}=", @translation.send(f)
    end

    seo_attributes.each do |f|
      self.send("seo_#{f}=", @seo.send(f))
    end
  end

  def persisted?
    true
  end

  def save(params)
    non_seo_attributes.each do |f|
      self.send "#{f}=", params[f.to_sym]
    end

    seo_attributes.each do |f|
      self.send("seo_#{f}=", params["seo_#{f}".to_sym])
    end

    if valid?
      save_object
      true
    else
      false
    end
  end

  def seo_attributes
    %w(title keywords description custom_head slug)
  end

  def non_seo_attributes
    attributes.keys.select { |k| !k.to_s.starts_with?('seo_') }
  end

  private

  def save_object
    non_seo_attributes.each do |f|
      @translation.send "#{f}=", self.send(f)
    end

    seo_attributes.each do |f|
      @seo.send("#{f}=", send("seo_#{f}"))
    end

    # Saves the model, translation and SEO info all at once.
    @seo.save!
    @model.save!
  end
end
