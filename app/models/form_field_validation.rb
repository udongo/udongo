class FormFieldValidation < ActiveRecord::Base
  include Concerns::Sortable
  belongs_to :form_field

  validates :form_field, :validation_class, :form_field, presence: true
end
