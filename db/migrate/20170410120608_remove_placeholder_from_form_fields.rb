class RemovePlaceholderFromFormFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :form_fields, :placeholder
  end
end
