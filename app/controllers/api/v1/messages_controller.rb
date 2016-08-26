class Api::V1::MessagesController < ApplicationController

  def index

  end

  def create
      @message = Message.new(message_params)
      @message.sender_id = current_user.id
      if @message.save
        render json: @message, status: :ok
      else
        render json: @message.errors, status:  :unprocessable_entity
      end
  end


  def destroy

  end

  private
  def message_params
    params.require(:message).permit(:receiver_id, :text)
  end
end
