class AddLocalesToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :locales, :text, after: :form_id
  end
end
