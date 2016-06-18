class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :claim_id

      t.timestamps null: false
    end
  end
end
