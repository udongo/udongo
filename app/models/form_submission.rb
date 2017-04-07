class FormSubmission < ApplicationRecord
  include Concerns::Emailable
  include Concerns::Searchable

  # TODO: Make this searchable by adding the key/value columns on data
  # as accessible attributes on FormSubmission.

  belongs_to :form
  has_many :data, class_name: 'FormSubmissionData'

  validates :form, presence: true

  def data_object
    data.inject(OpenStruct.new) do |stack, d|
      stack.send("#{d.name}=", d.value)
      stack
    end
  end
end
