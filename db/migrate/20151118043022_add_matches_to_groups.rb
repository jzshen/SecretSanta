class AddMatchesToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :matches, :text
  end
end
