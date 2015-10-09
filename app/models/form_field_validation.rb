class FormFieldValidation < ActiveRecord::Base
  include Concerns::Sortable
  belongs_to :field, class_name: 'FormField'

  validates :field, :validation_class, presence: true
end
