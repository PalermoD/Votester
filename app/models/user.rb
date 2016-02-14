class User < ActiveRecord::Base
	acts_as_voter
	
	has_many :posts, dependent: :destroy
	has_many :comments
	before_save { self.email = email.downcase}
	validates :name, presence: true, length: {maximum: 50} 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
	                            format: { with: VALID_EMAIL_REGEX },
	                            uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, on: :create

	def feed
	   Post.all
	end
	
end 
