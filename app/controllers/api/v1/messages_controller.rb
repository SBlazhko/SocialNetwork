class Api::V1::MessagesController < ApplicationController

  api :GET, 'profile/messages', "Show user massages"
  formats ['json']
  param :receiver_id, :number, "Receiver id", required: true
  param :page, :number, "Number page"
  example '
  Response -{
    "total_pages": 3,
    "messages": [
        {
            "id": 1,
            "text": "first message test",
            "sender_id": 4,
            "receiver_id": 5,
            "created_at": "2016-08-26T12:22:26.060Z",
            "updated_at": "2016-08-26T12:22:26.060Z"
        },
        {
            "id": 2,
            "text": "first message test",
            "sender_id": 4,
            "receiver_id": 5,
            "created_at": "2016-08-26T12:23:46.749Z",
            "updated_at": "2016-08-26T12:23:46.749Z"
        },
        {
            "id": 3,
            "text": "first message test",
            "sender_id": 4,
            "receiver_id": 5,
            "created_at": "2016-08-26T12:30:45.589Z",
            "updated_at": "2016-08-26T12:30:45.589Z"
        }
    ]
}'
  def index
    @messages = Message.where("(sender_id = ? AND receiver_id = ?) OR (receiver_id = ? AND sender_id = ?)",
                              current_user.id,
                              params[:receiver_id],
                              current_user.id,
                              params[:receiver_id]).order("created_at").page(params[:page]).per(3)
    if @messages.empty?
      head :no_content
    else
      render json: { total_pages: @messages.total_pages, messages: @messages }, status: :ok
    end
  end

  api :POST, 'profile/message', "Create an message"
  formats ['json']
  param :receiver_id, :number, "Receiver id", required: true
  param :text, String, "Text message", required: true
  error 404, "Receiver not found"
  error 422, "Unprocessable Entity"
  example '
  Request - {"receiver_id": "5", "text": "Lorem ipsum dolor"}
  Response - {
    "id": 7,
    "text": "Lorem ipsum dolor",
    "sender_id": 4,
    "receiver_id": 5,
    "created_at": "2016-08-28T15:57:55.940Z",
    "updated_at": "2016-08-28T15:57:55.940Z"
  }'
  def create
    if exists_receiver?
      @message = Message.new(message_params)
      @message.sender_id = current_user.id
      if @message.save
        render json: @message, status: :ok
      else
        render json: @message.errors, status:  :unprocessable_entity
      end
    else
      render json: { error: "Receiver not found" }, status: 404
    end
  end

  api :DELETE, 'profile/message', "Delete an message"
  param :id, :number, "id message", required: true
  error 422, "Unprocessable Entity"
  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      head :no_content
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:receiver_id, :text)
  end
end
