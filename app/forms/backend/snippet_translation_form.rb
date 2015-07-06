class Backend::SnippetTranslationForm < Reform::Form
  include Composition

  model :snippet

  property :title, on: :translation
  property :content, on: :translation
end
