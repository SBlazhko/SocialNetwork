# User Info
class Api::V1::UserInfosController < ApplicationController
  before_action :push_infos, only: [:create]

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
        registration_ids = ["fl1n1H_82Ck:APA91bFjzSel7CFH61eetWR9YfEVVe6oQgsNK1bWNdp6lKG2y5D3DL5gta79NmqnMgN5kYvh9Mx3Si5yU54w9irTvTC4zbizOhvgcPTC-VHuLAlft72U2y_Co0UbITaVU5nmdIq1ZM3t"]
        options = {"notification": {
    "title": "Portugal vs. Denmark",
    "text": "5 to 1"
  }}
        response = @fcm.send(registration_ids, options)
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

  private
  def push_infos
     @fcm = FCM.new(Rails.application.secrets.push_server_key)
  end
  
end
