class FormSubmissionDataDecorator < ApplicationDecorator
  delegate_all

  def label
    field = form_submission.form.fields.find_by(identifier: name)
    return field.label if field && field.label.present?
    name
  end
end
