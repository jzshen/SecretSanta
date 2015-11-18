class Group < ActiveRecord::Base
	has_many :memberships, :dependent => :destroy
	has_many :users, :through => :memberships
	validates :name, presence: true
	serialize :matches

	def add_member!(user)
		find_or_create_member(user)
	end

	def add_members!(users)
		users.map do |user|
			add_member!(user)
		end
	end
	
	def find_or_create_member(user)
		Member.find_or_create_by(user_id: user.id, group_id: id) do |m|
			m.group = self
			m.user  = user
		end
	end
end
