class Backend::FormTranslationForm < Backend::TranslationForm
  attribute :success_message, String

  def self.model_name
    Form.model_name
  end
end
