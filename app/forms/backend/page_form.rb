class Backend::PageForm < Udongo::Form
  attr_reader :page

  attribute :identifier, String
  attribute :description, String

  validates :identifier, :description, presence: true
  validate :unique_identifier

  delegate :id, to: :page

  def self.model_name
    Page.model_name
  end

  def persisted?
    !@page.new_record?
  end

  private

  def unique_identifier
    qry = Page.unscoped
    qry = qry.where.not(identifier: @page.identifier) if persisted?

    if qry.exists?(identifier: identifier)
      errors.add :identifier, I18n.t('errors.messages.taken')
    end
  end

  def save_object
    init_object_values(@page)
    @page.save!
  end
end
