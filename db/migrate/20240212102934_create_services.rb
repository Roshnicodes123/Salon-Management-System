class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string   :name
      t.string :description
      t.string :price
      t.belongs_to   :salon # Only if using reconfirmable

      t.timestamps
    end
  end
end
