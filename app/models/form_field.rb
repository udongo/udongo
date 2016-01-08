class FormField < ActiveRecord::Base
  include Concerns::Sortable
  sortable scope: [:form_id]

  include Concerns::Translatable
  translatable_fields :label, :default_value, :placeholder

  belongs_to :form
  has_many :validations,
    class_name: 'FormFieldValidation',
    dependent: :destroy

  validates :form, :name, :field_type, presence: true
end
