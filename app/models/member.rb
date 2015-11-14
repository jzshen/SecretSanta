class Member < ActiveRecord::Base	
	belongs_to :group 
	belongs_to :user
	has_many :statuses, :class_name => 'MemberStatus', :foreign_key => [:user_id, :group_id]
end
