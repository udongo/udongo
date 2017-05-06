class ReaddForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.text :locales
      t.string :identifier
      t.string :description

      t.timestamps null: false
    end
    add_index :forms, :identifier


    create_table :form_fields do |t|
      t.references :form, index: true
      t.text :locales
      t.string :name
      t.string :field_type
      t.string :default_value
      t.string :placeholder
      t.integer :position
      t.timestamps null: false
    end


    create_table :form_submissions do |t|
      t.references :form, index: true
      t.text :extra_info
      t.timestamps null: false
    end


    create_table :form_submission_data, force: :cascade do |t|
      t.references :form_submission, index: true
      t.string :name
      t.text :value
      t.timestamps null: false
    end
  end
end
