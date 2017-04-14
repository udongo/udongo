class RemoveDefaultValueFromFormFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :form_fields, :default_value
  end
end
