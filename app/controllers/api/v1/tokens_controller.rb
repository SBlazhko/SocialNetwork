class Api::V1::TokensController < ApplicationController
  before_action :get_profile_id, only: [:login, :logout]
  after_action :device_push_token_create, only: [:login]
	skip_before_action :authenticate!

	api :POST, 'login', "Generate new user token"
	param :login, String, "Profile login"
	param :password, String, "Profile password"
	error code: 401, desc: "Invalid email or password"
	example 'Request - {"login":"examplee","password":"111111"}'
	example 'Response - {"token": "4HkaLZUQMKWEEXHgPwUPDE28"}'

	def login
		if profile = Profile.find_by(login: params[:login]).try(:authenticate, params[:password])
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
			render json: { errors: {invalid: "Invalid login or password"} }, status: 401
		end
	end

	api :POST, 'logout', "Destroy profile token(logout)"
	param :token, String, "Profile token"

	def logout
		token = Token.find_by(token: request.headers["HTTP_AUTHORIZATION"])
	    if token.destroy
				render json: {}, status: 204
	    else
	    	render json: {errors: {not_found: "Token not found"}}, status: 422
	    end
	end

	private
  def get_profile_id
    @profile_id = Token.find_by(token: request.headers["HTTP_AUTHORIZATION"]).profile_id
  end

  def device_push_token_create
    @device = Device.new(profile_id: @profile_id, token: params[:push_token], platform: params[:platform])
    @device.save
  end

end
