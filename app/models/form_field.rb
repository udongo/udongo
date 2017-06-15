class FormField < ApplicationRecord
  include Concerns::Sortable
  sortable scope: [:form_id]

  include Concerns::Translatable
  translatable_fields :label, :default_value

  FIELD_TYPES = %w(string text integer collection email tel)

  belongs_to :form

  validates :form, :identifier, :field_type, presence: true

  validates_uniqueness_of :identifier, scope: :form_id
end
