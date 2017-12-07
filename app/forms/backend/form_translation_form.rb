class Backend::FormTranslationForm < Backend::TranslationForm
  attribute :summary, String
  attribute :toggle, String
  attribute :redirect_url, String
  attribute :success_message, String
  attribute :code_snippet, String

  def self.model_name
    Form.model_name
  end
end
