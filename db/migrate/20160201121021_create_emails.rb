class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :from_name
      t.string :from_email
      t.string :to_name
      t.string :to_email
      t.string :subject
      t.text :plain_content
      t.text :html_content
      t.string :locale
      t.datetime :sent_at

      t.timestamps null: false
    end
  end
end
