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

  api :GET, '/user/info/', "Show user infos"
  formats ['json']
  param :profile_id, :number, "Profile id of the User"
  param :access_level, ["level_one", "level_two", "level_three"], "Access level of the info"
  def show
    info = UserInfo.where(profile_id: params[:profile_id],
                          access_level: params[:access_level])
    if info.empty?
      head :no_content
    else
      render json: { user_info: info }, status: :ok
    end
  end

  api :POST, '/user/info', "Create an info"
  formats ['json']
  param_group :info_create
  error 422, "Unprocessable Entity"
  example " {'profile_id': '1', 'access_level': 'level_one', 'data': { 'key': 'value', ... , 'key': 'value'  }} "
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

  api :PUT, '/user/info', "Update an info"
  formats ['json']
  error 422, "Unprocessable Entity"
  param_group :info_update
  example " {'id': '2', 'access_level': 'level_one', 'data': { 'key': 'value', ... , 'key': 'value'  }} "
  def update
    @info.access_level = params[:access_level]
    @info.data = params[:data]
    if @info.save
      render json: @info, status: :ok
    else
      render json: @info.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/user/info', "Delete an info"
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
