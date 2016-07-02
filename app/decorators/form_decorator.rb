class FormDecorator < Draper::Decorator
  delegate_all

  def email_present?
    Form.first.data.select('DISTINCT name').map(&:name).include?('email')
  end
end
