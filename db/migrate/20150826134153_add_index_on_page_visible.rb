class AddIndexOnPageVisible < ActiveRecord::Migration
  def change
    add_index :pages, :visible
  end
end
