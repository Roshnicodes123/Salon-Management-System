class AddStartTimeAndEndTimeToSalons < ActiveRecord::Migration[7.1]
  def change
    add_column :salons, :start_time, :time
    add_column :salons, :end_time, :time
  end
end
