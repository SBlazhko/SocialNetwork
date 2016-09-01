class Api::V1::MessagesController < ApplicationController

  api :POST, 'message', 'Create new message'
  param :chat_room_id, :number, 'ChatRoom id (query param)'
  example MessageHelper.create

  def create
    message = Message.new(message_params)
    message.chat_room_id = ChatRoom.find_by(id: params[:chat_room_id]).id
    message.sender_id = current_user.id

    if chat_room.users.include?(current_user.id)
        if message.save
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
end
