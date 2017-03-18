class AddInvestigatorFields < ActiveRecord::Migration
  def change
    add_column :investigators, :lastname, :string    
  end
end
