class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :identifier
      t.boolean :html_title
      t.boolean :html_content

      t.timestamps null: false
    end

    add_index :snippets, :identifier
  end
end
