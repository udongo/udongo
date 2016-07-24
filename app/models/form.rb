class Form < ApplicationRecord
  include Concerns::Translatable
  translatable_fields :success_message

  has_many :fields, class_name: 'FormField', dependent: :destroy
  has_many :submissions, class_name: 'FormSubmission', dependent: :destroy
  has_many :data, through: :submissions

  validates :identifier, presence: true
end
