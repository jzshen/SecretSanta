class Membership < ActiveRecord::Base	
	belongs_to :group 
	belongs_to :user
	has_many :statuses, :class_name => 'MemberStatus', :foreign_key => [:user_id, :group_id]
	validates :group_id, uniqueness: { scope: :user_id }
	

	def self.join_group(user: nil, group: nil)
		user.ability.authorize! :join, group
		member = group.add_member!(user)
	end

	def group_name
  		if self.group
    		@group_name ||= self.group.name
  		end
	end

	def group_name=(group_name)
  		@group_name = group_name
  		self.group = Group.find_by_name(@group_name)
	end

end
