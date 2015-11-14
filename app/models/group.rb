class Group < ActiveRecord::Base
	has_many :members, :dependent => :destroy
	has_many :users, :through => :members
	validates :name, presence: true
end
