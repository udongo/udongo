class AddTitleAndContentDisabledToSnippet < ActiveRecord::Migration[5.0]
  def change
    add_column :snippets, :title_disabled, :boolean, after: 'description'
    add_column :snippets, :content_disabled, :boolean, after: 'allow_html_in_title'
  end
end
