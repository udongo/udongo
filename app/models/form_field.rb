class FormField < ActiveRecord::Base
  include Concerns::Sortable
  belongs_to :form

  validates :form, :name, :field_type, presence: true
end
