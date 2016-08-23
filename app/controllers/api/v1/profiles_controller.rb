class  Api::V1::ProfilesController < ApplicationController

	def show 
		respond_to do |format|
			format.json {render json: Profile.find(current_user.id)}
		end
	end

	def index 
		respond_to do |format|
			format.json {render json: Profile.all}
		end
	end

	def create
		profile = Profile.new(profile_params)
		profile.save
		token = Token.new
		token.profile_id = profile.id
		token.token = token.generate_unique_secure_token
		respond_to do |format|
			if token.save
				format.json {render json: {profile: profile, token: token }, status: 201 }
			else 
				format.json {render json: {errors: profile.errors}, status: 422}
			end
		end
	end

	def update
		respond_to do |format|
			if current_user.update(profile_params)
				format.json {render json: current_user, status: 200}
			else
				format.json {render json: {errors: current_user.errors}, status: 422}
			end
		end
	end

	def destroy 
		respond_to do |format|
			if current_user.destroy
				format.json { head :no_content, status: 200}
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