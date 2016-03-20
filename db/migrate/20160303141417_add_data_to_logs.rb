class AddDataToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :data, :text, after: 'content'
  end
end
