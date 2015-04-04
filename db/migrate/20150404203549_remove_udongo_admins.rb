class RemoveUdongoAdmins < ActiveRecord::Migration
  def change
    drop_table :udongo_admins
  end
end
