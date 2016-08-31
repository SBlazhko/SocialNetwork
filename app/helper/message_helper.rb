module MessageHelper
	class << self

		def create
			'Request - {"message" : {"text" : "message"}}
			Response - {
			  "id": 4,
			  "chat_room_id": 2,
			  "sender_id": 1,
			  "text": "message",
			  "created_at": "2016-08-30T13:48:22.689Z"
			}'
		end

	end
end
