class Backend::FormFieldTranslationForm < Backend::TranslationForm
  attribute :label, String

  def self.model_name
    FormField.model_name
  end
end
