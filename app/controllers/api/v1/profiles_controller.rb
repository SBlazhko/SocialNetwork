class  Api::V1::ProfilesController < ApplicationController

	skip_before_action :authenticate!, only: [:create]

	api :GET, 'profile', "Show profile data"
	param :id, :number, "Profile id", required: true
	error code: 404, desc: "Profile not found"
	def show 
		profile = Profile.find(params[:id])
		respond_to do |format|
			format.json {render json: {id: profile.id, login: profile.login, created_at: profile.created_at}, status: 200 }
		end
	end

	api :GET, 'profiles', "Show all profiles"
	def index 
		profiles = Profile.all
		respond_to do |format|
			format.json {render json: profiles}
		end
	end

	api :POST, 'profiles', "Create new profile"
	param :profile, Hash, "Profile Hash", required: true do
		param :login, String, "Unique profile login", required: true
		param :password, String, "Profile password, minimum 6 symbols", required: true
	end
	example "{'profile' : {'login' : 'test', 'password' : '111111'}}"
	error code: 422
	def create
		profile = Profile.new(profile_params)
		profile.save
		token = Token.new
		token.profile_id = profile.id
		token.token = token.generate_unique_secure_token
		respond_to do |format|
			if token.save
				format.json {render json: {id: profile.id, login: profile.login, token: token.token, created_at: profile.created_at }, status: 201 }
			else 
				format.json {render json: {errors: profile.errors}, status: 422}
			end
		end
	end

	api :PUT, 'profile', "Update profile data"
	param :profile, Hash, "Profile Hash", required: true do
		param :login, String, "Unique profile login", required: true
		param :password, String, "Profile password, minimum 6 symbols", required: true
	end
	error code: 422 
	def update
		respond_to do |format|
			if current_user.update(profile_params)
				format.json {render json: current_user, status: 200}
			else
				format.json {render json: {errors: current_user.errors}, status: 422}
			end
		end
	end

	api :DELETE, 'profile', "Delete profile"
	param :token, String, "Profile token"
	error code: 422
	def destroy 
		respond_to do |format|
			if current_user.destroy
				format.json {render json: {success: 'user destoyed'}, status: 204}
			else
				format.json {render json: {errors: current_user.errors}, status: 422}
			end
		end
	end

	private
	def profile_params
		params.require(:profile).permit(:login, :password)
	end
end