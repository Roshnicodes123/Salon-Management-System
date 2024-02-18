class CreateSeats < ActiveRecord::Migration[7.1]
  def change
    create_table :seats do |t|
      t.string :name
      t.string :status, default: 'available'
      t.references :salon, null: false, foreign_key: true

      t.timestamps
    end
  end
end