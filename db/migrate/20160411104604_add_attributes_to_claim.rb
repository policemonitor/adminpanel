class AddAttributesToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :lastname, :string
    add_column :claims, :phone, :string
    add_column :claims, :latitude, :string
    add_column :claims, :longitude, :string
    add_column :claims, :theme, :string
    add_column :claims, :text, :text
    add_column :claims, :status, :boolean
    add_column :claims, :crew_id, :integer
    add_column :claims, :administrator_id, :integer
  end
end
