# TODO write spec for this class
class ContentImageDecorator < Draper::Decorator
  delegate_all

  def text?
    false
  end

  def image?
    true
  end
end
