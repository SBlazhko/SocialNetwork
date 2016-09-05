class Api::V1::ChatRoomsController < ApplicationController

	before_action :find_chat_room, only: [:show_all_messages, :show, :destroy, :add_profile_to_chat]

	api :POST, 'chat_room', 'Create new ChatRoom'
	param :users, Array, of: Integer 
	param :title, String, 'Chat name'
	example ChatRoomHelper.create

	def create
		chat_room = ChatRoom.new(chat_room_params)
		chat_room.profile_id = current_user.id
		c = params[:chat_room][:users] << current_user.id
		chat_room.users = Profile.where("id IN (?)", c.sort.uniq).ids
		if ChatRoom.where('users = ARRAY[?]', chat_room.users).exists?
				render json: {errors: {chat_room: 'already exists'}}, status: 400
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

	api :GET, 'chat_room_all_messages', 'Show ChatRoom with messages'
	param :chat_room_id, :number, 'ChatRoom id (query param)'
	param :page, :number, 'Page number (query param)'
	example ChatRoomHelper.show_all_messages

	def show_all_messages
		messages = chat_room.messages.page(params[:page]).per(10)
		if chat_room.users.include?(current_user.id)
			render json: {chat_room: chat_room, pages: {total: messages.total_pages, current: messages.current_page, 
				message_count: messages.count}, messages: messages}, status: 200
		else
			render json: {errors: {access: "failed"}}
		end
	end

	api :GET, 'chat_room', 'Show ChatRoom last message'
	param :chat_room_id, :number, 'ChatRoom id (query param)'
	example ChatRoomHelper.show

	def show
		if chat_room.users.include?(current_user.id)
			render json: {chat_room: chat_room, last_message: chat_room.messages.last}, status: 200
		else
			render json: {errors: {access: "failed"}}
		end
	end

	api :DELETE, 'chat_room', 'Delete chat_room only creator'
	param :chat_room_id, :number, 'ChatRoom id (query param)'

	def destroy
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

	def find_chat_room
		chat_room = ChatRoom.find_by(id: params[:chat_room_id])
	end
end