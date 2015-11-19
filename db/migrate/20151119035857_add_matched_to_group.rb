class AddMatchedToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :matched, :boolean, :default => false
  end
end
