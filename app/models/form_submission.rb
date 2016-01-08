class FormSubmission < ActiveRecord::Base
  belongs_to :form
  has_many :data, class_name: 'FormSubmissionData'

  validates :form, presence: true
  # TODO: belongs_to :visitor
end
