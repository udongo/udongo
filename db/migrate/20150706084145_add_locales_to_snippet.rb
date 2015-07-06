class AddLocalesToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :locales, :text, after: 'html_content'
  end
end
