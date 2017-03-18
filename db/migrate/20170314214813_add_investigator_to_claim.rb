class AddInvestigatorToClaim < ActiveRecord::Migration
  def change
    add_reference :claims, :investigator, index: true
  end
end
