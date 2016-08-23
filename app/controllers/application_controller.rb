class ApplicationController < ActionController::API
	include ActionController::MimeResponds

	before_action :authentificate!, only: [:destroy, :update]

	def authentificate!
		if Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
		else 
			render json: {error: 'token invalid'}, status: 401 
		end
	end

	def current_user
		token = Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
		token.profile if token
	end
end
