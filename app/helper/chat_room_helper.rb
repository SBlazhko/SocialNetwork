module ChatRoomHelper
	class << self
		
		def create
			'Request - {"chat_room" : {"title" : "Big Colts Salun :)"}}

			Response - {
			  "id": 10,
			  "title": "TestChat",
			  "profile_id": 1,
			  "users": [
			    1,
			    3
			  ],
			  "created_at": "2016-08-30T14:09:04.898Z",
			  "updated_at": "2016-08-30T14:09:04.898Z"
			}'
		end

		def my_chats
			'[
			  {
			    "id": 5,
			    "title": "TestChat",
			    "profile_id": 1,
			    "users": [
			      1,
			      2
			    ],
			    "created_at": "2016-08-30T14:02:59.459Z",
			    "updated_at": "2016-08-30T14:02:59.459Z"
			  },
			  {
			    "id": 6,
			    "title": "TestChat",
			    "profile_id": 1,
			    "users": [
			      1,
			      2
			    ],
			    "created_at": "2016-08-30T14:03:08.928Z",
			    "updated_at": "2016-08-30T14:03:08.928Z"
			  },
			  {
			    "id": 7,
			    "title": "TestChat",
			    "profile_id": 1,
			    "users": [
			      1,
			      2
			    ],
			    "created_at": "2016-08-30T14:03:12.281Z",
			    "updated_at": "2016-08-30T14:03:12.281Z"
			  }]'
		end

		def index
			'[
			  {
			    "id": 5,
			    "title": "TestChat",
			    "profile_id": 1,
			    "users": [
			      1,
			      2
			    ],
			    "created_at": "2016-08-30T14:02:59.459Z",
			    "updated_at": "2016-08-30T14:02:59.459Z"
			  },
			  {
			    "id": 6,
			    "title": "TestChat",
			    "profile_id": 1,
			    "users": [
			      1,
			      2
			    ],
			    "created_at": "2016-08-30T14:03:08.928Z",
			    "updated_at": "2016-08-30T14:03:08.928Z"
			  },
			  {
			    "id": 7,
			    "title": "TestChat",
			    "profile_id": 1,
			    "users": [
			      1,
			      2
			    ],
			    "created_at": "2016-08-30T14:03:12.281Z",
			    "updated_at": "2016-08-30T14:03:12.281Z"
			  }]'
		end

		def show
			'{
		  "chat_room": {
		    "id": 10,
		    "title": "TestChat",
		    "profile_id": 1,
		    "users": [
		      1,
		      3,
		      2
		    ],
		    "created_at": "2016-08-30T14:09:04.898Z",
		    "updated_at": "2016-08-30T14:46:06.854Z"
		  },
		  "messages": [
		    {
		      "id": 5,
		      "chat_room_id": 10,
		      "sender_id": 1,
		      "text": "TestText",
		      "created_at": "2016-08-30T16:06:16.896Z",
		      "updated_at": "2016-08-30T16:06:16.896Z"
		    },
		    {
		      "id": 6,
		      "chat_room_id": 10,
		      "sender_id": 1,
		      "text": "TestText",
		      "created_at": "2016-08-30T16:06:20.092Z",
		      "updated_at": "2016-08-30T16:06:20.092Z"
		    }]'
		end
	end
end