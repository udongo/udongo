class Backend::EmailTemplateForm < Udongo::Form
  attr_reader :email_template

  attribute :identifier, String
  attribute :description, String
  attribute :from_name, String
  attribute :from_email, String

  validates :identifier, :description, :from_name, :from_email, presence: true
  validates :from_email, email: true
  validate :unique_identifier

  delegate :id, to: :email_template

  def self.model_name
    EmailTemplate.model_name
  end

  def persisted?
    !@email_template.new_record?
  end

  private

  def unique_identifier
    qry = EmailTemplate.unscoped
    qry = qry.where.not(identifier: @email_template.identifier) if persisted?

    if qry.exists?(identifier: identifier)
      errors.add :identifier, I18n.t('errors.messages.taken')
    end
  end

  def save_object
    init_object_values(@email_template)
    @email_template.save!
  end
end
