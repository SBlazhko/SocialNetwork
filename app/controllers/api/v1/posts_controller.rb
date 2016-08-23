class  Api::V1::PostsController < ApplicationController

	before_action :authentificate!

	def create
		binding.pry
		user = current_user.user

	end
end
