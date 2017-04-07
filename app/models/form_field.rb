class FormField < ApplicationRecord
  include Concerns::Sortable
  sortable scope: [:form_id]

  include Concerns::Translatable
  translatable_fields :label, :default_value, :placeholder

  belongs_to :form

  validates :form, :name, :field_type, presence: true
end
