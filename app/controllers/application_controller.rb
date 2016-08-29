class ApplicationController < ActionController::Base

  include ActionController::MimeResponds
	
	before_action :authenticate!

	def authenticate!
		if Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
		else
			render json: {error: 'token invalid'}, status: 401
		end
	end

	def current_user
		token = Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
		token.profile if token
	end

	def exists_receiver?
		Profile.exists?(params[:receiver_id])
	end
end
