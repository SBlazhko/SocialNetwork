class AuthTableToken < ApplicationRecord
belongs_to :profile
  def generate_unique_secure_token
	    return  SecureRandom.base58(24)
	end
end
