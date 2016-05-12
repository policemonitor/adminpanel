class StatusDisabledForAdministrator < ActiveRecord::Migration
  def change
    add_column :administrators, :fired, :boolean, default: false
  end
end
