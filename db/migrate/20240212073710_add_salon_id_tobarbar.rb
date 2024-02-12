class AddSalonIdTobarbar < ActiveRecord::Migration[7.1]
  def change
    add_column :barbars, :salon_id, :integer
  end
end
