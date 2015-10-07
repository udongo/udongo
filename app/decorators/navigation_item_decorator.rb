class NavigationItemDecorator < Draper::Decorator
  delegate_all

  def label
    if object.translation.label.present?
      object.translation.label

    elsif object.page.present?
      object.page.translation.title

    else
      ''
    end
  end

  def path
  end
end
