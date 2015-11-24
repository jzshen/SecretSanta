class AddMembershipPreferencesToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :membership_preferences, :text
  end
end
