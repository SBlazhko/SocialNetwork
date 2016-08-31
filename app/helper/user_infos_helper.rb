module UserInfosHelper
	class << self

		def index
			'Response - {
			  "user_info": [
			    {
			      "id": 12,
			      "data": {
			        "age": "18",
			        "last_name": "shaman",
			        "first_name": "test"
			      },
			      "profile_id": 2,
			      "created_at": "2016-08-24T17:27:35.276Z",
			      "updated_at": "2016-08-24T17:27:35.276Z",
			      "access_level": "level_two"
			    },
			    {
			      "id": 13,
			      "data": {
			        "age": "55",
			        "last_name": "test3",
			        "first_name": "test2"
			      },
			      "profile_id": 2,
			      "created_at": "2016-08-25T06:53:08.217Z",
			      "updated_at": "2016-08-25T06:53:08.217Z",
			      "access_level": "level_two"
			    }
			  ]'
		end

		def create
		  'Request - {"profile_id": "18", "access_level": "level_two", "data": {"age": "55", ... , "last_name": "Kaniuk"}
		  Response - {
		  "id": 19,
		  "data": {
		    "age": "55",
		    ... ,
		    "last_name": "Kaniuk"
		  },
		  "profile_id": "18",
		  "created_at": "2016-08-25T11:23:05.386Z",
		  "updated_at": "2016-08-25T11:23:05.386Z",
		  "access_level": "level_two"
		}'
		end

		def update
			 'Request - {"id": "19", "access_level": "level_one", "data": {"age": "55", ... , "last_name": "Kaniuk"}
			  Response - {
			  "access_level": "level_one",
			  "data": {
			    "age": "55",
			    ... ,
			    "last_name": "Kaniuk"
			  },
			  "id": 19,
			  "profile_id": 18,
			  "created_at": "2016-08-25T11:23:05.386Z",
			  "updated_at": "2016-08-25T13:39:07.730Z"
			}'
		end
	end	 
end