class AddAtributesToCrews < ActiveRecord::Migration
  def change
    add_column :crews, :car_number, :integer
    add_column :crews, :vin_number, :integer
    add_column :crews, :underway, :boolean, default: true
    add_column :crews, :on_a_mission, :boolean, default: false
    add_column :crews, :latitude, :string
    add_column :crews, :longtitude, :string
  end
end
