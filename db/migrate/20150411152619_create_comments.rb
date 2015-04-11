class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.string :locale
      t.integer :parent_id
      t.string :author
      t.string :email
      t.string :website
      t.text :message
      t.string :status
      t.boolean :marked_as_spam

      t.timestamps null: false
    end

    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
