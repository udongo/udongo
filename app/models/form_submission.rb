class FormSubmission < ActiveRecord::Base
  belongs_to :form
  has_many :data, foreign_key: :submission_id, class_name: 'FormSubmissionData'

  validates :form, presence: true
  # TODO: belongs_to :visitor

  def data_as_hash
    data.inject({}) do |stack, d|
      stack[d.name.to_sym] = d.value
      stack
    end
  end
end
