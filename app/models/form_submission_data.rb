class FormSubmissionData < ActiveRecord::Base
  belongs_to :form_submission

  validates :form_submission, presence: true
end
