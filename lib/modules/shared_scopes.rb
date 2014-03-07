module Modules::SharedScopes
	def self.included(base)
		base.class_eval do
			scope :from_most_recent, lambda { order("created_at DESC") }
		end
	end
end