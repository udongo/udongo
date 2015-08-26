class AddTimesUsedToRedirect < ActiveRecord::Migration
  def change
    add_column :redirects, :times_used, :integer, after: 'disabled'
  end
end
