class ChangeCrewTable < ActiveRecord::Migration
  def change
    rename_column :crews, :underway, :on_duty
    add_column :crews, :crew_name, :string

    add_index :crews, :vin_number, unique: true
    add_index :crews, :car_number, unique: true
  end
end
