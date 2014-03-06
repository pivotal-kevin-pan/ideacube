class User < ActiveRecord::Base
	has_many :ideas, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_ideas, through: :likes, source: :idea

	has_many :comments, dependent: :destroy


	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, 
				format: { with: VALID_EMAIL_REGEX }, 
				uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 } # BCrypt adds a password presence validation on default. Adding one here creates two similar error messages when the password field is empty on submission
	validates :password_confirmation, presence: true

	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end