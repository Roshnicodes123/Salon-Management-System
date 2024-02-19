class AddSeatCapacityToSalons < ActiveRecord::Migration[7.1]
  def change
    add_column :salons, :seat_capacity, :integer, default: 10
  end
end
