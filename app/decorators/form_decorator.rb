class FormDecorator < Draper::Decorator
  delegate_all

  def datagrid
    @datagrid ||= Udongo::Forms::SubmissionDatagrid.new(object)
  end

  def email_present?
    Form.first.data.select('DISTINCT name').map(&:name).include?('email')
  end
end
