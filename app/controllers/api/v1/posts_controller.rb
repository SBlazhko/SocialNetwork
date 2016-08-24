class  Api::V1::PostsController < ApplicationController


	def create
		binding.pry
		user = current_user.user

	end
end
