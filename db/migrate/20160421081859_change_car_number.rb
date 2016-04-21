class ChangeCarNumber < ActiveRecord::Migration
  def change
    remove_column :crews, :longtitude
    add_column :crews, :longitude, :string

    change_column :crews, :car_number, :string
    change_column :crews, :vin_number, :string
  end
end
