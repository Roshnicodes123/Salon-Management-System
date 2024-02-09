class AddStatustoBarbars < ActiveRecord::Migration[7.1]
  def change
    add_column :barbars, :status, :integer, default: 0
  end
end
