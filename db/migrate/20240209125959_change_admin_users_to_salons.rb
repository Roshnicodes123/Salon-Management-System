class ChangeAdminUsersToSalons < ActiveRecord::Migration[7.1]
  def change
    rename_table :admin_users, :salons
  end
end
