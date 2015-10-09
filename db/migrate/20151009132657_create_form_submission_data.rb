class CreateFormSubmissionData < ActiveRecord::Migration
  def change
    create_table :form_submission_data do |t|
      t.references :form_submission, index: true
      t.string :name
      t.text :value

      t.timestamps null: false
    end
  end
end
