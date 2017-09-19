class AddExternalReferenceToContentColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :content_columns, :external_reference, :string, after: 'content_id'
    add_index :content_columns, :external_reference
  end
end
