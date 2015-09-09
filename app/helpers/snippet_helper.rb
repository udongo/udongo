module SnippetHelper
  def snippet(identifier)
    ::Snippet.find_in_cache(identifier).decorate
  end
end
