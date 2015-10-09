class Form < ActiveRecord::Base
  has_many :fields, class_name: 'FormField'
end
