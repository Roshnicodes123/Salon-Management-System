class AddUsernameToBarbars < ActiveRecord::Migration[7.1]
  def change
    add_column :barbars, :username, :string
  end
end
