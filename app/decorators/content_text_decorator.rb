class ContentTextDecorator < ApplicationDecorator
  delegate_all

  def render
    content.to_s.html_safe
  end
end
