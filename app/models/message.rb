class Message < ApplicationRecord
	belongs_to :chat_room
	belongs_to :profile, foreign_key: 'sender_id'

	validates :text, length: { minimum: 2, maximum: 100 }

	def message_show_params
		{
			id: id,
			chat_room_id: chat_room_id,
			sender_id: sender_id,
			text: text,
			created_at: created_at
		}
	end

end
