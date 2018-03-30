class Backend::TagTranslationForm < Backend::TranslationWithSeoForm
  attribute :summary, String

  def self.model_name
    Tag.model_name
  end
end
