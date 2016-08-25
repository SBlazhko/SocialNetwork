	class Api::V1::TokensController < ApplicationController

	skip_before_action :authenticate!

	api :POST, 'login', "Generate new user token"
	param :login, String, "Profile login"
	param :password, String, "Profile password"
	error code: 401, desc: "Invalid email or password"
	example "{'profile' : {'login' : 'test', 'password' : '111111'}}"
	def login 
		if profile = Profile.find_by(login: params[:profile][:login]).try(:authenticate, params[:profile][:password])
			token = Token.new
			token.token = token.generate_unique_secure_token 
			token.profile_id = profile.id
		respond_to do |format|
			if token.save
				format.json {render json: {token: token.token}, status: 200 }
			else
				format.json {render json: {errors: token.errors}, status: 422}
			end
		end
		else
			render json: { errors: "Invalid email or password" }, status: 422
		end 
	end

	api :POST, 'logout', "Destroy profile token(logout)"
	param :token, String, "Profile token"
	error code: 422, desc: "Token not found"

	def logout
		token = Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
	    if token.destroy
	    	render json: {}, status: 204
	    else
	    	render json: {error: "Token not found"}, status: 422
	    end
	end
end