class SnippetDecorator < Draper::Decorator
  def title
    object.html_title? ? object.title.to_s.to_html : object.title
  end

  def content
    object.html_content? ? object.content.to_s.to_html : object.content
  end
end
