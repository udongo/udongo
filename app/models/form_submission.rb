class FormSubmission < ActiveRecord::Base
  belongs_to :form
  has_many :data, class_name: 'FormSubmissionData'
  has_many :fields, class_name: 'FormField'

  validates :form, presence: true
end
