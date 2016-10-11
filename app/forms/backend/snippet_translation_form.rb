class Backend::SnippetTranslationForm < Udongo::Form
  attr_reader :snippet, :translation

  attribute :title, String
  attribute :content, String

  delegate :id, to: :snippet

  def initialize(snippet, translation)
    @snippet = snippet
    @translation = translation

    init_attribute_values(translation)
  end

  def self.model_name
    Snippet.model_name
  end

  def persisted?
    true
  end

  private

  def save_object
    init_object_values(@translation)
    @snippet.save
  end
end
