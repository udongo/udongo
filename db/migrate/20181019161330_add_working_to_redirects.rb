class AddWorkingToRedirects < ActiveRecord::Migration[5.0]
  def change
    add_column :redirects, :working, :boolean, after: :times_used
  end
end
