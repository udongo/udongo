class Backend::FormTranslationForm < Backend::TranslationForm
  attribute :redirect_url, String
  attribute :toggle, String
  attribute :success_message, String

  def self.model_name
    Form.model_name
  end
end
