class FormSubmissionData < ApplicationRecord
  belongs_to :form_submission

  validates :form_submission, presence: true
end
