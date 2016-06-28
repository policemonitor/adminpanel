class AddDeletedToCrews < ActiveRecord::Migration
  def change
    add_column :crews, :deleted, :boolean, default: false
  end
end
