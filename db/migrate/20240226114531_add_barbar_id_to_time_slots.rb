class AddBarbarIdToTimeSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots, :barbar_id, :integer
    add_index :time_slots, :barbar_id
  end
end
