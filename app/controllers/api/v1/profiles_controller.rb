class  Api::V1::ProfilesController < ApplicationController

	skip_before_action :authenticate!, only: [:create]

	api :GET, 'profile', "Show profile data by id"
	param :id, :number, "Profile id (query param)", required: true
	example 'Response - {"id": 1,
	    "login": "example",
	    "created_at": "2016-08-25T14:13:36.622Z"}'

	def show 
		respond_to do |format|
			format.json {render json: Profile.find(params[:id]).profile_show_params, status: 200 }
		end
	end

	api :GET, 'my_profile', "Show current_user profile"
	example 'Response - "id": 1,
	    "login": "example",
	    "created_at": "2016-08-25T14:13:36.622Z"}'
	def my_profile 
	 	respond_to do |format|
	 		format.json {render json: Profile.find(current_user.id).profile_show_params, status: 200}
	 	end
	end 

	api :GET, 'profiles', "Show all profiles"
	param :page, :number, "Page number (query param)"
	example 'Response - {"pages": {
		"total": 3,
		"current": 1}, 
	"profiles" : [
	  {
	    "id": 1,
	    "login": "example",
	    "created_at": "2016-08-25T14:13:36.622Z"
	  },
	  {
	    "id": 2,
	    "login": "example2",
	    "created_at": "2016-08-25T14:27:05.789Z"
	  },
	  {
	    "id": 3,
	    "login": "example3",
	    "created_at": "2016-08-25T14:27:12.923Z"}]'

	def index 
		profiles = Profile.all.page(params[:page]).per(10)
		respond_to do |format|
			format.json {render json: {pages: {total: profiles.total_pages, current: profiles.current_page}, 
															profiles: profiles.map(&:profile_show_params)}}
		end
	end

	api :POST, 'profile', "Create new profile"
	param :profile, Hash, "Profile Hash", required: true do
		param :login, String, "Unique profile login", required: true
		param :password, String, "Profile password, minimum 6 symbols", required: true
	end
	example 'Request - {"profile" : {"login":"test", "password":"111111"}}'
	example 'Response - {"profile": {
		"id": 13,
		"login": "test223",
		"created_at": "2016-08-29T11:35:28.956Z"},
		"token": "zJ37UVyv9qHVxkCQ4ZUneTAH"}'

	def create
		profile = Profile.new(profile_params)
		profile.save
		token = Token.new
		token.profile_id = profile.id
		token.token = token.generate_unique_secure_token
		respond_to do |format|
			if token.save
				format.json {render json: {profile: profile.profile_show_params, token: token.token}, status: 201 }
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
	example 'Request - {"profile" : {"login":"test2", "password":"222222"}}'

	def update
		respond_to do |format|
			if current_user.update(profile_params)
				format.json {render json: current_user.profile_show_params, status: 200}
			else
				format.json {render json: {errors: current_user.errors}, status: 304}
			end
		end
	end

	api :DELETE, 'profile', "Delete profile"
	param :token, String, "Profile token"

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