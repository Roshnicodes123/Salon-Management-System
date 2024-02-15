class AddColumnToSalon < ActiveRecord::Migration[7.1]
  def change
    add_column :salons, :address, :string
    add_column :salons, :start_time, :datetime
    add_column :salons, :end_time, :datetime
  end
end
