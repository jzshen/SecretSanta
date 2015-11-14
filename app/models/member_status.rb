class MemberStatus < ActiveRecord::Base
	belongs_to :members, :foreign_key => [:user_id, :group_id]
end
