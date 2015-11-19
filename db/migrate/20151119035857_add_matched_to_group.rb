class AddMatchedToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :matched, :boolean
  end
end
