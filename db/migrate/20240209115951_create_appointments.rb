class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :user
      t.belongs_to :barbar
      t.belongs_to :salon
      t.belongs_to :service
      t.datetime  :date_time

      t.timestamps
    end
  end
end
