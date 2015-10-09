class FormSubmissionData < ActiveRecord::Base
  belongs_to :submission, class_name: 'FormSubmission'

  validates :submission, presence: true
end
