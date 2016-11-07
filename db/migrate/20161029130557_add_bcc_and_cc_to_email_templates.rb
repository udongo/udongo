class AddBccAndCcToEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :cc, :string, after: 'from_email'
    add_column :email_templates, :bcc, :string, after: 'cc'
  end
end
