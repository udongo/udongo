class Backend::FormFieldTranslationForm < Backend::TranslationForm
  attribute :label, String
  attribute :default_value, String

  def self.model_name
    FormField.model_name
  end
end
