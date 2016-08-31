class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.string 	:title
      t.integer :profile_id
      t.integer :users, array: true, default: []

      t.timestamps
    end
  end
end
