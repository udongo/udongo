class ReoraganizeSnippetHtmlFields < ActiveRecord::Migration
  def change
    rename_column :snippets, :html_title, :allow_html_in_title
    rename_column :snippets, :html_content, :editor_for_content
    add_column :snippets, :allow_html_in_content, :boolean, after: 'allow_html_in_title'
  end
end
