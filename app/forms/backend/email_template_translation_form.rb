class Backend::EmailTemplateTranslationForm < Backend::TranslationForm
  attribute :subject, String
  attribute :plain_content, String
  attribute :html_content, String

  validates :subject, :plain_content, :html_content, presence: true

  def self.model_name
    EmailTemplate.model_name
  end
end
