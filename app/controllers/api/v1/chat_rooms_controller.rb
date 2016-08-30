class Api::V1::ChatRoomsController < ApplicationController
	
	def create
		chat_room = ChatRoom.new(chat_room_params)
		chat_room.profile_id = current_user.id
		# binding.pry
		chat_room.users[0] = current_user.id 
		chat_room.users[1] = Profile.find(params[:id]).id
		respond_to do |format|
			if chat_room.save
				format.json {render json: chat_room, status: 201}
			else
				format.json {render json: {errors: chat_room.errors}, status: 400} 
			end
		end
	end

	def index
		chat_rooms = ChatRoom.all.page(params[:page]).per(10)
		respond_to do |format|
			format.json {render json: chat_rooms, status: 200}
		end
	end

	#fix show
	def show
		chat_room = ChatRoom.find(params[:id])
		respond_to do |format|
			format.json {render json: {chat_room: chat_room, messages: chat_room.messages}, status: 200}
		end
	end

	def destroy
		chat_room = ChatRoom.find(params[:id])
		if chat_room.profile_id == current_user.id
			chat_room.destroy
		else 
			render json: {errors: {user: "not owner"}}
		end
	end

	private
	  def chat_room_params
	    params.require(:chat_room).permit(:title)
	  end
end