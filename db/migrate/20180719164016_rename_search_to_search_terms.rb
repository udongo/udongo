class RenameSearchToSearchTerms < ActiveRecord::Migration[5.0]
  def change
    rename_table :searches, :search_terms
  end
end
