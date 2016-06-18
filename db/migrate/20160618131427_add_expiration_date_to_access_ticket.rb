class AddExpirationDateToAccessTicket < ActiveRecord::Migration
  def change
    add_column :accesses, :expiration, :datetime
  end
end
