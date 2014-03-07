class Comment < ActiveRecord::Base
	include Modules::SharedScopes

	belongs_to :user
	belongs_to :idea

	validates :user_id, presence: true
	validates :idea_id, presence: true
	validates :content, presence: true

end
