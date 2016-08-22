class Profile < ApplicationRecord
	has_secure_password 

	has_many :messages
	has_many :posts
	has_many :attachment_files
	has_many :user_infos
	has_many :tokens

	validates :login, uniqueness: true, presence: true
end
