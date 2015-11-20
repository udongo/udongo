class AddExternalReferenceToTags < ActiveRecord::Migration
  def change
    add_column :tags, :external_reference, :string, after: 'slug'
    add_index :tags, :external_reference
  end
end
