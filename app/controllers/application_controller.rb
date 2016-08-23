class ApplicationController < ActionController::API
	include ActionController::MimeResponds


	private

	def authenticate_user!
	  binding.pry
	  client_token = Token.find_by(token: token)
	  profile = Profile.find_by(client_token.profile_id) 
	end
end
