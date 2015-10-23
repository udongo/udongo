class Form < ActiveRecord::Base
  include Concerns::Translatable
  translatable_fields :success_message

  has_many :fields, class_name: 'FormField'
end
