class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
      t.integer :car_number
      t.integer :vin_number
      t.boolean :underway, default: true
      t.boolean :on_a_mission, default: false
      t.string  :latitude
      t.string  :longtitude
      t.timestamps null: false
    end
  end
end
