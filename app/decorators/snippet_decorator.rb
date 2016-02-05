class SnippetDecorator < Draper::Decorator
  def title
    string = object.title.to_s
    object.allow_html_in_title? ? string.html_safe : string
  end

  def content
    string = object.content.to_s
    object.allow_html_in_content? ? string.html_safe : string
  end
end
