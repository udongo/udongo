class CreateFormSubmissions < ActiveRecord::Migration
  def change
    create_table :form_submissions do |t|
      t.references :form, index: true
      t.text :extra_info

      t.timestamps null: false
    end
  end
end
