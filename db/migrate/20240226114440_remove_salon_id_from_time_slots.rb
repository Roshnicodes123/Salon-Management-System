class RemoveSalonIdFromTimeSlots < ActiveRecord::Migration[7.1]
  def change
    remove_column :time_slots, :salon_id, :integer
  end
end
