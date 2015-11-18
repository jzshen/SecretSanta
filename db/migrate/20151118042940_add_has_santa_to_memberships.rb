class AddHasSantaToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :has_santa, :boolean
  end
end
