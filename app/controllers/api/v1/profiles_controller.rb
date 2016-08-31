class  Api::V1::ProfilesController < ApplicationController

	skip_before_action :authenticate!, only: [:create]

	api :GET, 'profile', "Show profile data by id"
	param :id, :number, "Profile id (query param)", required: true
	example ProfileHelper.show

	def show 
		render json: Profile.find(params[:id]).profile_show_params, status: 200 
	end

	api :GET, 'my_profile', "Show current_user profile"
	example ProfileHelper.my_profile

	def my_profile 
	 	render json: Profile.find(current_user.id).profile_show_params, status: 200
	end 

	api :GET, 'profiles', "Show all profiles"
	param :page, :number, "Page number (query param)"
	example ProfileHelper.index

	def index 
		profiles = Profile.all.page(params[:page]).per(10)
		render json: {pages: {total: profiles.total_pages, current: profiles.current_page}, 
											profiles: profiles.map(&:profile_show_params)}
	end

	api :POST, 'profile', "Create new profile"
	param :profile, Hash, "Profile Hash", required: true do
		param :login, String, "Unique profile login", required: true
		param :password, String, "Profile password, minimum 6 symbols", required: true
	end
	example ProfileHelper.create

	def create
		profile = Profile.new(profile_params)
		profile.save
		token = Token.new
		token.profile_id = profile.id
		token.token = token.generate_unique_secure_token
		if token.save
			render json: {profile: profile.profile_show_params, token: token.token}, status: 201 
		else 
			render json: {errors: profile.errors}, status: 422
		end
	end

	api :PUT, 'profile', "Update profile data"
	param :profile, Hash, "Profile Hash", required: true do
		param :login, String, "Unique profile login", required: true
		param :password, String, "Profile password, minimum 6 symbols", required: true
	end
	example 'Request - {"profile" : {"login":"test2", "password":"222222"}}'

	def update
		if current_user.update(profile_params)
			render json: current_user.profile_show_params, status: 200
		else
			render json: {errors: current_user.errors}, status: 304
		end
	end

	api :DELETE, 'profile', "Delete profile"
	param :token, String, "Profile token"

	def destroy 
		if current_user.destroy
			render json: {success: 'user destoyed'}, status: 204
		else
			render json: {errors: current_user.errors}, status: 422
		end
	end

	private
	def profile_params
		params.require(:profile).permit(:login, :password)
	end
end