class Api::V1::ChatRoomsController < ApplicationController
	
	api :POST, 'chat_room', 'Create new ChatRoom'
	param :receiver_id, :number, 'receiver id'
	param :title, String, 'Chat name'
	example ChatRoomHelper.create

	def create
		chat_room = ChatRoom.new(chat_room_params)
		chat_room.profile_id = current_user.id
		chat_room.users[0] = current_user.id 
		chat_room.users[1] = Profile.find_by(id: params[:receiver_id]).id
		if ChatRoom.where('users = ARRAY[?]', chat_room.users).exists?
				render json: {errors: {chat_room: 'already exists'}}
		else
			if chat_room.save
				render json: chat_room, status: 201
			else
				render json: {errors: chat_room.errors}, status: 400
			end
		end
	end

	api :GET, 'chat_rooms', 'Show all ChatRooms'
	example ChatRoomHelper.index

	def index
		render json: ChatRoom.all, status: 200
	end

	api :GET, 'chat_room', 'Show ChatRoom with messages by id'
	param :chat_room_id, :number, 'ChatRoom id (query param)'
	example ChatRoomHelper.show

	def show
		chat_room = ChatRoom.find_by(id: params[:chat_room_id])
		if chat_room.users.include?(current_user.id)
			render json: {chat_room: chat_room, messages: chat_room.messages}, status: 200
		else
			render json: {errors: {access: "failed"}}
		end
	end

	api :DELETE, 'chat_room', 'Delete chat_room only creator'
	param :chat_room_id, :number, 'ChatRoom id (query param)'

	def destroy
		chat_room = ChatRoom.find_by(id: params[:chat_room_id])
		if chat_room.profile_id == current_user.id
			chat_room.destroy
		else 
			render json: {errors: {user: "not owner"}}
		end
	end

	api :POST, 'add_profile_to_chat','add_profile_to_chat only owner'
	param :chat_room_id, :number, 'ChatRoom id (query param)'
	param :profile_id, :number, 'Profile id (query param)'

	def add_profile_to_chat
		chat_room = ChatRoom.find_by(id: params[:chat_room_id])
		id = Profile.find_by(id: params[:profile_id]).id 
		if chat_room.profile_id == current_user.id && !chat_room.users.include?(id)
			chat_room.users << id 
			chat_room.save 
			render json: {success: "user add to chat_room #{chat_room.id}"}
		else
			render json: {errors: {user: "not owner or user already exist"}}
		end
	end

	api :GET, 'my_chats', 'Show all current_user chats'
	example ChatRoomHelper.my_chats

	def my_chats
		render json: ChatRoom.where('users @> ARRAY[?]', current_user.id)
	end

	private

	def chat_room_params
	  params.require(:chat_room).permit(:title)
	end
end