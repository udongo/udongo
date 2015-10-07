class NavigationItemDecorator < Draper::Decorator
  delegate_all

  def label
    result = ''
    result = object.translation.label if object.translation.label
    result = object.page.translation.title if object.page && result.blank?
    result
  end

  def path(options = {})
    result = '/'

    if object.translation.path.present?
      result = object.translation.path

    elsif object.page.present?
      result = object.page.decorate.path(options)
    end

    result
  end

  def options_for_page
    ::Page.order(:description).map do |p|
      [p.description, p.id]
    end
  end
end
