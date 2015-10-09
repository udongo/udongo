class FormFieldValidation < ActiveRecord::Base
  include Concerns::Sortable
  sortable scope: [:field_id]

  include Concerns::Translatable
  translatable_fields :error_message

  belongs_to :field, class_name: 'FormField'

  validates :field, :validation_class, presence: true
end
