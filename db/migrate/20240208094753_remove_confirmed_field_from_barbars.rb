class RemoveConfirmedFieldFromBarbars < ActiveRecord::Migration[7.1]
  def change
    remove_column :barbars, :confirmed_at, :datetime
    remove_column :barbars, :confirmation_token, :string
    remove_column :barbars, :confirmation_sent_at, :datetime
    remove_column :barbars, :unconfirmed_email, :string
    
  end
end
