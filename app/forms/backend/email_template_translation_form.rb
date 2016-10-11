class Backend::EmailTemplateTranslationForm < Udongo::Form
  attr_reader :email_template, :translation

  attribute :subject, String
  attribute :plain_content, String
  attribute :html_content, String

  validates :subject, :plain_content, :html_content, presence: true

  delegate :id, to: :email_template

  def initialize(email_template, translation)
    @email_template = email_template
    @translation = translation

    init_attribute_values(@translation)
  end

  def self.model_name
    EmailTemplate.model_name
  end

  def persisted?
    true
  end

  private

  def save_object
    init_object_values(@translation)
    @email_template.save
  end
end
