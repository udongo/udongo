class FormSubmissionData < ApplicationRecord
  belongs_to :submission, class_name: 'FormSubmission'

  validates :submission, presence: true
end
