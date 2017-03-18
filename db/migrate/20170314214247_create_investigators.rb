class CreateInvestigators < ActiveRecord::Migration
  def change
    create_table :investigators do |t|
      t.timestamps null: false
    end
  end
end
