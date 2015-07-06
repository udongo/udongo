class AddDescriptionToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :description, :text, after: 'identifier'
  end
end
