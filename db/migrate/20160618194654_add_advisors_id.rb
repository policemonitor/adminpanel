class AddAdvisorsId < ActiveRecord::Migration
  def change
    add_column :accesses, :administrator_id, :integer  
  end
end
