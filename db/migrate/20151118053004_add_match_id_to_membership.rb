class AddMatchIdToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :match_id, :integer
  end
end
