class Backend::EmailTemplateTranslationForm < Reform::Form
  include Composition

  model :email_template

  property :subject, on: :translation
  property :plain_content, on: :translation
  property :html_content, on: :translation

  validates :subject, :plain_content, :html_content, presence: true
end
