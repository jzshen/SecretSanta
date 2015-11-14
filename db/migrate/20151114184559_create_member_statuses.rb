class CreateMemberStatuses < ActiveRecord::Migration
  def change
    create_table :member_statuses do |t|
      t.text :status

      t.timestamps null: false
    end
  end
end
