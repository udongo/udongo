class AddDepthToRedirects < ActiveRecord::Migration[5.0]
  def change
    add_column :redirects, :depth, :integer, after: :times_used
  end
end
