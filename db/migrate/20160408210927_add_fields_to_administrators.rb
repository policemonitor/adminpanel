class AddFieldsToAdministrators < ActiveRecord::Migration
  def change
    add_column :administrators, :personal_number, :string
    add_column :administrators, :rank, :integer

    add_index :administrators, :personal_number, unique: true
    add_index :administrators, :login, unique: true
  end
end
