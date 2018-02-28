class AddAttachmentsToEmails < ActiveRecord::Migration[5.0]
  def change
    add_column :emails, :attachments, :text, after: 'locale'
  end
end
