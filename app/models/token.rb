class Token < ApplicationRecord
	belongs_to :profile

	def generate_unique_secure_token
        SecureRandom.base58(24)
	end
end
