class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.chat_room_id = ChatRoom.find_by(id: params[:chat_room_id]).id
    message.sender_id = current_user.id
    respond_to do |format|
      if message.save
        format.json {render json: message.message_show_params, status: 201}
      else
        format.json {render json: {errors: message.errors}, status: 400}
      end
    end
  end

  def destroy
    message = Message.find(params[:id])
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
