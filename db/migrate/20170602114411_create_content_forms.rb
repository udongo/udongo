class CreateContentForms < ActiveRecord::Migration[5.0]
  def change
    create_table :content_forms do |t|
      t.references :form

      t.timestamps
    end
  end
end
