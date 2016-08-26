class  Api::V1::PostsController < ApplicationController

	api :GET, 'profile/posts', "Show all posts current_profile"
	param :id, :number, "Profile id (query param)", required: true
	example "[
	  {
	    'id': 6,
	    'profile_id': 5,
	    'access_level': 'level_one',
	    'text': 'test text',
	    'created_at': '2016-08-25T21:46:50.582Z'
	  },
	  {
	    'id': 7,
	    'profile_id': 5,
	   	'access_level': 'level_one',
	    'text': 'test text',
	    'created_at': '2016-08-25T21:47:20.413Z'} ]"

	def index 
		posts = current_user.posts
		respond_to do |format|
			format.json {render json: posts.map(&:post_show_params), status: 200}
		end
	end

	api :POST, 'profile/post', "Create new post"
	param :access_level, ["level_one", "level_two", "level_three"], "Access level of the post", required: true
	param :text, String, "Post message", required: true
	example "Request - {'access_level' : 'level_three', 'text':'test text'}"
	example "Response - {'id': 8,
	  'profile_id': 5,
	  'access_level': 'level_one',
	  'text': 'test text',
	  'created_at': '2016-08-25T21:47:22.927Z'}"

	def create
		post = Post.new(post_params)
		post.profile_id = current_user.id
		respond_to do |format|
			if post.save
				format.json {render json: post.post_show_params, status: 201}
			else
				format.json {render json: {errors: post.errors}, status: 422}
			end
		end
	end 

	api :GET, 'profile/post', "Show post by id"
	param :id, :number, "Post id (query param)"
	example "Response - {'id': 8,
	  'profile_id': 5,
	  'access_level': 'level_one',
	  'text': 'test text',
	  'created_at': '2016-08-25T21:47:22.927Z'}"

	def show
		respond_to do |format|
			 format.json {render json: Post.find(params[:id]).post_show_params, status: 200}
		end
	end

	api :PUT, 'profile/post', "Update post"
	param :id, :number, "Post id (query param)"
	param :access_level, ["level_one", "level_two", "level_three"], "Access level of the post"
	example "Request - {'access_level' : 'level_two', 'text':'Update text'}"

	def update
		post = Post.find(params[:id])
		respond_to do |format|
			if post.update(post_params)
				format.json {render json: post.post_show_params, status: 200 }
			else
				format.json {render json: post.errors, status: 304}
			end
		end
	end

	api :DELETE, 'profile/post', "Delete post"
	param :id, :number, "Post id (query param)"

	def destroy
		respond_to do |format|
			if Post.find(params[:id]).destroy
				format.json {render json: {success: 'post destoyed'}, status: 204}
			else
				format.json {render json: {errors: post.errors}, status: 422}
			end
		end
	end

	private
	def post_params
		params.require(:post).permit(:access_level, :text)
	end
end
