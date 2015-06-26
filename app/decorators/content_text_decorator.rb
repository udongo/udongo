# TODO write spec for this class
class ContentTextDecorator < Draper::Decorator
  delegate_all

  def render
    content.to_s.html_safe
  end

  def text?
    true
  end

  def image?
    false
  end
end
