class FormDecorator < ApplicationDecorator
  delegate_all

  def email_present?
    data.select('DISTINCT name').map(&:name).include?('email')
  end
end
