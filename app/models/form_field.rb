class FormField < ActiveRecord::Base
  include Concerns::Sortable
  sortable scope: [:form_id]

  include Concerns::Translatable
  translatable_fields :label, :default_value, :placeholder

  belongs_to :form
  has_many :validations,
    class_name: 'FormFieldValidation',
    foreign_key: :field_id,
    dependent: :destroy

  validates :form, :name, :field_type, presence: true
end
