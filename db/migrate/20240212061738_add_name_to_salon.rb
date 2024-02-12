class AddNameToSalon < ActiveRecord::Migration[7.1]
  def change
    add_column :salons, :name, :string
  end
end
