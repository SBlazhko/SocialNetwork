# User Info
class Api::V1::UserInfosController < ApplicationController
  before_action :set_info, only: [:update, :destroy]

  def_param_group :info_create do
    param :info, Hash do
      param :profile_id, :number, "Profile id of the User"
      param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
      param :data, Hash, "Hash from info fields"
    end
  end

  def_param_group :info_update do
    param :info, Hash do
      param :id, :number, "The id info"
      param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
      param :data, Hash, "Hash from info fields"
    end
  end

  api :GET, '/profile/info/', "Show user infos"
  formats ['json']
  param :profile_id, :number, "Profile id of the User"
  param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
  example 'Response - {
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
  def show
    info = UserInfo.where(profile_id: params[:profile_id],
                          access_level: params[:access_level])
    if info.empty?
      head :no_content
    else
      render json: { user_info: info }, status: :ok
    end
  end

  api :POST, '/profile/info', "Create an info"
  formats ['json']
  param_group :info_create
  error 422, "Unprocessable Entity"
  example '
  Request - {"profile_id": "18", "access_level": "level_two", "data": {"age": "55", ... , "last_name": "Kaniuk"}
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
  def create
    @info = UserInfo.new(info_params)
    @info.data = params[:data]
    @info.profile_id = current_user.id
    if @info.save
      render json: @info, status: :created
    else
      render json: @info.errors, status:  :unprocessable_entity
    end
  end

  api :PUT, '/profile/info', "Update an info"
  formats ['json']
  error 422, "Unprocessable Entity"
  param_group :info_update
  example '
  Request - {"id": "19", "access_level": "level_one", "data": {"age": "55", ... , "last_name": "Kaniuk"}
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
  def update
    @info.access_level = params[:access_level]
    @info.data = params[:data]
    if @info.save
      render json: @info, status: :ok
    else
      render json: @info.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/profile/info', "Delete an info"
  formats ['json']
  error 422, "Unprocessable Entity"
  param :id, :number,
  def destroy
    if @info.destroy
      head :no_content
    else
      render json: @info.errors, status: :unprocessable_entity
    end
  end

  private

  def set_info
    @info = UserInfo.find(params[:id])
  end

  def info_params
    params.require(:user_info).permit(:profile_id, :access_level)
  end
end
