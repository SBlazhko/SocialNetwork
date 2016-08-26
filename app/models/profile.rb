class Profile < ApplicationRecord
	has_secure_password 

	has_many :tokens, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :messages
	has_many :attachment_files
	has_many :user_infos

	validates :login, uniqueness: true, presence: true
	validates :password, length: { minimum: 6 }, allow_blank: true

	def profile_show_params
	{ id: id,
	  login: login,
	  created_at: created_at }	
	end

	# def as_json(options={})
	# 	super(options.merge({ exept: [:id, :login, :created_at]} ))
	# end
end
