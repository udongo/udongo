class Backend::SnippetForm < Udongo::Form
  attr_reader :snippet

  attribute :identifier, String
  attribute :description, String

  validates :identifier, :description, presence: true
  validate :unique_identifier

  delegate :id, to: :snippet

  def initialize(snippet = nil)
    @snippet = snippet || Snippet.new
    attributes.keys.each { |k| send("#{k}=", @snippet.send(k)) } if snippet
  end

  def self.model_name
    Snippet.model_name
  end

  def persisted?
    !@snippet.new_record?
  end

  private

  def unique_identifier
    qry = Snippet.unscoped
    qry = qry.where.not(identifier: @snippet.identifier) if persisted?

    if qry.exists?(identifier: identifier)
      errors.add :identifier, I18n.t('errors.messages.taken')
    end
  end

  def save_object
    attributes.each { |k, v| @snippet.send("#{k}=", v) }
    @snippet.save!
  end
end
