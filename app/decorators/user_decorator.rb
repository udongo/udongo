class UserDecorator < ApplicationDecorator
  delegate_all

  def abbreviation
    base = display_name.present? ? display_name : full_name
    return email if base.blank?
    base.split(' ').map(&:first).join('')
  end
end
