# User Info
class Api::V1::UserInfosController < ApplicationController

  api :GET, 'profile/info/', "Show user infos"
  formats ['json']
  param :profile_id, :number, "Profile id of the User", required: true
  param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
  example 'Response - {
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
  def index
    if params[:access_level]
      info = UserInfo.where(profile_id: params[:profile_id],
                            access_level: params[:access_level])
    else
      info = UserInfo.where(profile_id: params[:profile_id])
    end
    if info.empty?
      head :no_content
    else
      render json: { user_info: info }, status: :ok
    end
  end

  api :POST, 'profile/info', "Create an info"
  formats ['json']
  param :user_infos, Array, "Array of hashes"
  param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
  param :key, String
  param :value, String
  error 422, "Unprocessable Entity"
  example '
  Request - {"user_infos": [
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
  def create
    result = []
    params[:user_infos].each do |info|
      infos = UserInfo.new(profile_id: current_user.id,
      key: info[:key],
      value: info[:value],
      access_level: info[:access_level])
      if infos.save
        result << infos
      else
        render json: info.errors, status:  :unprocessable_entity
      end
    end
    render json: { user_infos: result }, status: :created
  end

  api :PUT, 'profile/info', "Update an info"
  formats ['json']
  error 422, "Unprocessable Entity"
  param :user_infos, Array, "Array of hashes"
  param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
  param :id, :number, "Info id"
  param :key, String
  param :value, String
  example '
  Request - {"user_infos": [
{"id": "39", "access_level": "level_three", "key": "first_name", "value": "test1"},
{"id": "40", "access_level": "level_three", "key": "last_neme", "value": "test"}
]}
  Response - {
    "user_infos": [
        {
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
        }
    ]
}'
  def update
    result = []
    params[:user_infos].each do |info|
      info  = UserInfo.find(info[:id])
      if info.update(access_level: info[:access_level],
                      key:  info[:key],
                      value: info[:value])
        result << info
      else
        render json: { errors: @info.errors }, status: :unprocessable_entity
      end
    end
    render json: { user_infos: result }, status: :ok
  end

  api :DELETE, 'profile/info', "Delete an info"
  formats ['json']
  error 422, "Unprocessable Entity"
  param :id, :number, required: true
  
  def destroy
    info = UserInfo.find(params[:id])
    if info.destroy
      head :no_content
    else
      render json: { errors: @info.errors }, status: :unprocessable_entity
    end
  end
end
