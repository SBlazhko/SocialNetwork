# User Info
class Api::V1::UserInfosController < ApplicationController

  api :GET, 'profile/info/', "Show user infos"
  formats ['json']
  param :profile_id, :number, "Profile id of the User", required: true
  param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
  example UserInfosHelper.index

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
  example UserInfosHelper.create

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
  example UserInfosHelper.update

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
