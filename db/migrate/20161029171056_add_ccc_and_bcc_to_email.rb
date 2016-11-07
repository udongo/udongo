class AddCccAndBccToEmail < ActiveRecord::Migration[5.0]
  def change
    add_column :emails, :cc, :string, after: 'to_email'
    add_column :emails, :bcc, :string, after: 'cc'
  end
end
