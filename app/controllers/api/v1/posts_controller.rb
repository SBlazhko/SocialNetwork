class  Api::V1::PostsController < ApplicationController


	def index 

	end

	def create
		
	end 

	def show

	end

	def update

	end

	def destroy

	end

	private
	def post_params
		params.require(:profile).permit(:login, :password)
	end
end
