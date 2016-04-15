class ChangeViewedColumnToDefaultValue < ActiveRecord::Migration
  def change
    remove_column :claims, :status
    add_column    :claims, :status, :boolean, default: false
  end
end
