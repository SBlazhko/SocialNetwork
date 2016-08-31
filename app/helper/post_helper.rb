module PostHelper
	class << self
		def index
			'Response - {"pages": {
	    "total": 2,
	    "current": 1
	  },
	  "profiles": [
	    {
	      "id": 1,
	      "login": "test",
	      "created_at": "2016-08-26T14:41:46.449Z"
	    },
	    {
	      "id": 2,
	      "login": "test2",
	      "created_at": "2016-08-26T14:43:25.329Z"
	    },
	    {
	      "id": 3,
	      "login": "test1",
	      "created_at": "2016-08-29T06:48:50.408Z"
	    }]}'
  	end

  	def create
  		'Request - {"access_level" : "level_three", "text" : "test text"}
			 Response - {"id": 8,
			  "profile_id": 5,
			  "access_level": "level_one",
			  "text": "test text",
			  "created_at": "2016-08-25T21:47:22.927Z"}'
		end

		def show
			'Response - {"id": 8,
	  "profile_id": 5,
	  "access_level": "level_one",
	  "text": "test text",
	  "created_at": "2016-08-25T21:47:22.927Z"}'
		end
	end
end