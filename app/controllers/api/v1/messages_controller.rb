class Api::V1::MessagesController < ApplicationController
  before_action :push_message_new, only: [:create]
  before_action :get_chat_room, only: [:create, :check_message_access?, :get_users_token]


  api :POST, 'message', 'Create new message'
  param :chat_room_id, :number, 'ChatRoom id (query param)'
  example MessageHelper.create

  def create
    message = Message.new(message_params)
    message.chat_room_id = @chat_room.id
    message.sender_id = current_user.id

    if check_message_access?
      if message.save
        registration_ids = get_users_token()
        options = {notification: { title: @chat_room.title,
                                   text: params[:text][0, 50] }}
        response = @fcm.send(registration_ids, options)
        render json: message.message_show_params, status: 201
      else
        render json: {errors: message.errors}, status: 400
      end
    else
      render json: {errors: {user: "access failed"}}
    end
  end

  api :DELETE, 'message', 'Delete message if owner'
  param :message_id, :number, 'Message id (query param)'

  def destroy
    message = Message.find_by(id: params[:message_id])
    if message.sender_id == current_user.id
      message.destroy
    else
      render json: {errors: {user: ["not owner"]}}
    end
  end


  private
  def message_params
    params.require(:message).permit(:text)
  end

  def check_message_access?
    @chat_room.users.each do |u|
      if u == current_user.id
        return true
      end
    end
    return false
  end

  def get_users_token
    @arr_profile_token = []
    chat_room = @chat_room
    chat_room.users.each do |id|
      device = Device.find_by(profile_id: id)
      unless device.nil?
        @arr_profile_token << device.token if  device.profile_id != current_user.id
      end
    end
    @arr_profile_token
  end

  def get_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def push_message_new
    @fcm = FCM.new(Rails.application.secrets.push_server_key)
  end

end
