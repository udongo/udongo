class ChangeDescColumnForSnippet < ActiveRecord::Migration
  def change
    change_column :snippets, :description, :string
  end
end
