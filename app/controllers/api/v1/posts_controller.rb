class  Api::V1::PostsController < ApplicationController

	api :GET, 'profile/posts', "Show all posts current_profile"
	param :page, :number, "Page number (query param)"
	example PostHelper.index

	def index 
		posts = current_user.posts.page(params[:page]).per(10)
		render json: {pages: {total: posts.total_pages, current: posts.current_page}, 
												posts: posts.map(&:post_show_params)}, status: 200
	end

	api :POST, 'profile/post', "Create new post"
	param :access_level, ["level_one", "level_two", "level_three"], "Access level of the post", required: true
	param :text, String, "Post message", required: true
	example PostHelper.create

	def create
		post = current_user.posts.new(post_params)
		if post.save
			render json: post.post_show_params, status: 201
		else
			render json: {errors: post.errors}, status: 422
		end
	end 

	api :GET, 'profile/post', "Show post by id"
	param :post_id, :number, "Post id (query param)"
	example PostHelper.show

	def show
		render json: Post.find_by(id: params[:post_id]).post_show_params, status: 200
	end

	api :PUT, 'profile/post', "Update post"
	param :post_id, :number, "Post id (query param)"
	param :access_level, ["level_one", "level_two", "level_three"], "Access level of the post"
	example 'Request - {"access_level" : "level_two", "text":"Update text"}'

	def update
		post = Post.find_by(id: params[:post_id])
		if post.update(post_params)
			render json: post.post_show_params, status: 200 
		else
			render json: post.errors, status: 304
		end
	end

	api :DELETE, 'profile/post', "Delete post"
	param :post_id, :number, "Post id (query param)"

	def destroy
		if Post.find_by(id: params[:post_id]).destroy
			render json: {success: 'post destoyed'}, status: 204
		else
			render json: {errors: post.errors}, status: 422
		end
	end

	private
	def post_params
		params.require(:post).permit(:access_level, :text)
	end
end
