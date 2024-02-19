class AddAddressToSalons < ActiveRecord::Migration[7.1]
  def change
    add_column :salons, :address, :string
  end
end
