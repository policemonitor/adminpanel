class ChangeAdminsTable < ActiveRecord::Migration
  def change
    rename_column :administrators, :name, :lastname
  end
end
