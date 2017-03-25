class RemoveCrewIdFromClaim < ActiveRecord::Migration
  def change
    remove_column :claims, :crew_id
  end
end
