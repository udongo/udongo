class Backend::SnippetTranslationForm < Backend::TranslationForm
  attribute :title, String
  attribute :content, String

  def self.model_name
    Snippet.model_name
  end
end
