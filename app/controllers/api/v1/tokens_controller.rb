	class Api::V1::TokensController < ApplicationController

	skip_before_action :authentificate!

	def create 
		if profile = Profile.find_by(login: params[:profile][:login]).try(:authenticate, params[:profile][:password])
			token = Token.new
			token.token = token.generate_unique_secure_token 
			token.profile_id = profile.id
		respond_to do |format|
			if token.save
				format.json {render json: token, status: 200 }
			else
				format.json {render json: {errors: token.errors}, status: 422}
			end
		end
		else
			render json: { errors: "Invalid email or password" }, status: 422
		end 
	end

	def destroy
		token = Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
	    token.token = token.generate_unique_secure_token
	    token.save
	    render json: {}, status: 204
	end
end