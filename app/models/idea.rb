class Idea < ActiveRecord::Base
	belongs_to :user

	has_many :likes, dependent: :destroy
	has_many :liked_by_users, through: :likes, source: :user
	has_many :comments, dependent: :destroy

	validates :description, presence: true, length: { maximum: 1000 }
	validates :title, presence: true, length: { maximum: 50 }
	validates :user_id, presence: true

	before_save :default_upvote_value

	def default_upvote_value
		self.upvotes ||= 0
	end
end
