class AddColumnToappointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :time_slot_id, :integer
  end
end
