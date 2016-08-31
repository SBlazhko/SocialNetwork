module ProfileHelper
	class << self
		def show
			'Response - {"id": 1,
	    "login": "example",
	    "created_at": "2016-08-25T14:13:36.622Z"}'
		end

		def my_profile
			'Response - "id": 1,
	    "login": "example",
	    "created_at": "2016-08-25T14:13:36.622Z"}'
		end

		def index
			'Response - {"pages": {
			"total": 3,
			"current": 1}, 
		"profiles" : [
	  {
	    "id": 1,
	    "login": "example",
	    "created_at": "2016-08-25T14:13:36.622Z"
	  },
	  {
	    "id": 2,
	    "login": "example2",
	    "created_at": "2016-08-25T14:27:05.789Z"
	  },
	  {
	    "id": 3,
	    "login": "example3",
	    "created_at": "2016-08-25T14:27:12.923Z"}]'
		end

		def create
		'Request - {"profile" : {"login":"test", "password":"111111"}} 

		Response - {"profile": {
		"id": 13,
		"login": "test223",
		"created_at": "2016-08-29T11:35:28.956Z"},
		"token": "zJ37UVyv9qHVxkCQ4ZUneTAH"}'
		end
	end
end