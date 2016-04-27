class CreateJoinTableCrewClaim < ActiveRecord::Migration
  def change
    create_join_table :crews, :claims do |t|
      # t.index [:crew_id, :claim_id]
      # t.index [:claim_id, :crew_id]
    end
  end
end
