class Backend::TagTranslationForm < Backend::TranslationWithSeoForm
  attribute :summary, String

  validates :summary, presence: true

  def self.model_name
    Tag.model_name
  end
end
