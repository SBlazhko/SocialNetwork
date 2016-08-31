module UserInfosHelper
  class << self

    def index
    'Response - {
      "user_info": [
        {
          "id": 36,
          "profile_id": 4,
          "created_at": "2016-08-29T19:37:30.488Z",
          "updated_at": "2016-08-30T06:10:48.441Z",
          "access_level": "level_three",
          "key": "first_name",
          "value": "shaman"
        },
        {
          "id": 40,
          "profile_id": 4,
          "created_at": "2016-08-29T19:39:07.061Z",
          "updated_at": "2016-08-30T06:18:33.255Z",
          "access_level": "level_three",
          "key": "last_neme",
          "value": "test"
        },
        {
          "id": 39,
          "profile_id": 4,
          "created_at": "2016-08-29T19:39:07.048Z",
          "updated_at": "2016-08-30T06:21:41.083Z",
          "access_level": "level_three",
          "key": "first_name",
          "value": "test1"
        }
    ]
}'
    end

    def create
      'Request - {"user_infos": [
                   {"key": "age", "value": "18", "access_level": "level_two"},
                   {"key": "first_name", "value": "Myron", "access_level": "level_two"},
                   {"key": "last_name", "value": "Kaniuk", "access_level": "level_one"}
]}
      Response - {
        "user_infos": [
        {
          "id": 45,
          "profile_id": 4,
          "created_at": "2016-08-29T20:04:56.477Z",
          "updated_at": "2016-08-29T20:04:56.477Z",
          "access_level": "level_two",
          "key": "age",
          "value": "18"
        },
        {
          "id": 46,
          "profile_id": 4,
          "created_at": "2016-08-29T20:04:56.548Z",
          "updated_at": "2016-08-29T20:04:56.548Z",
          "access_level": "level_two",
          "key": "first_name",
          "value": "Myron"
        },
        {
            "id": 47,
            "profile_id": 4,
            "created_at": "2016-08-29T20:04:56.558Z",
            "updated_at": "2016-08-29T20:04:56.558Z",
            "access_level": "level_one",
            "key": "last_name",
            "value": "Kaniuk"
        }
    ]
}'
    end

    def update
      'Request - {"user_infos": [
       {"id": "39", "access_level": "level_three", "key": "first_name", "value": "test1"},
       {"id": "40", "access_level": "level_three", "key": "last_neme", "value": "test"}
]}
Response - {
  "user_infos": [{
    "id": 39,
    "access_level": "level_three",
    "key": "first_name",
    "value": "test1",
    "profile_id": 4,
    "created_at": "2016-08-29T19:39:07.048Z",
    "updated_at": "2016-08-30T06:21:41.083Z"
  },
  {
    "id": 40,
    "access_level": "level_three",
    "key": "last_neme",
    "value": "test",
    "profile_id": 4,
    "created_at": "2016-08-29T19:39:07.061Z",
    "updated_at": "2016-08-30T06:18:33.255Z"
  }]
}'
    end
  end 
end
