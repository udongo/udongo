class LargerEmailPlainHtmlStorage < ActiveRecord::Migration#[5.0]
  def up
    change_column :emails, :plain_content, :text, limit: 16777215
    change_column :emails, :html_content, :text, limit: 16777215
  end

  def down
    change_column :emails, :plain_content, :text, limit: 65535
    change_column :emails, :html_content, :text, limit: 65535
  end
end
