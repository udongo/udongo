class ContentTextDecorator < Draper::Decorator
  delegate_all

  def render
    content.to_s.html_safe
  end

  def content_type_is?(value)
    value.to_sym == :text
  end
end
