class Backend::SnippetTranslationForm < Udongo::Form
  attr_reader :snippet, :translation

  attribute :title, String
  attribute :content, String

  delegate :id, to: :snippet

  def initialize(snippet, translation)
    @snippet = snippet
    @translation = translation

    self.title = translation.title
    self.content = translation.content
  end

  def self.model_name
    Snippet.model_name
  end

  def persisted?
    true
  end

  private

  def save_object
    attributes.each { |k, v| @translation.send("#{k}=", v) }
    @translation.save
  end
end
