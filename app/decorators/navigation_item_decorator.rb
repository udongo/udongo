class NavigationItemDecorator < Draper::Decorator
  delegate_all

  def label
    result = ''
    result = object.translation.label if object.translation.label
    result = object.page.translation.title if object.page && result.blank?
    result
  end

  def path
  end
end
