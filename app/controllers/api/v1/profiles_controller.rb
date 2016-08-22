class  Api::V1::ProfilesController < ApplicationController
	
	before_action

	def show 
		respond_to do |format|
			format.json {render json: Profile.find(params[:id])}
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
		t = Token.new
		t.profile_id = profile.id
		t.token = t.add_token(:activate, size: 20)
		t.save
		respond_to do |format|
			if profile.save 
				format.json {render json: profile.login, status: 201 }
			else 
				format.json {render json: {errors: profile.errors}, status: 422}
			end
		end
	end

	def update
		profile = Profile.find(params[:id])
		respond_to do |format|
			if profile.update(profile_params)
				format.json {render json: profile, status: 200}
			else
				format.json {render json: {errors: profile.errors}, status: 422}
			end
		end
	end

	def destroy 
		profile = Profile.find(params[:id])
		respond_to do |format|
			if profile.destroy
				format.json { head :no_content, status: 200}
			else
				format.json {render json: {errors: profile.errors}, status: 422}
			end
		end
	end
	private
	def profile_params
		params.require(:profile).permit(:login, :password)
	end

end