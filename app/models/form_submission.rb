class FormSubmission < ActiveRecord::Base
  include Concerns::Emailable

  belongs_to :form
  has_many :data, foreign_key: :submission_id, class_name: 'FormSubmissionData'

  validates :form, presence: true
  # TODO: belongs_to :visitor

  def data_object
    data.inject(OpenStruct.new) do |stack, d|
      stack.send("#{d.name}=", d.value)
      stack
    end
  end
end
