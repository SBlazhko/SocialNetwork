class Api::V1::UserInfosController < ApplicationController

  before_action :set_info, only: [:show, :update, :destroy]
  before_action :set_json, only: [:create, :update]


  def show
    arr = {}
    level = params[:accsses_level]
    data = @info.data
    data.each do |key, value|
      arr[key] = value if value["accsses_level"] == level
    end
    render json: arr, status: :ok
  end


  def create
    @info = UserInfo.new(info_params)
    @info.data = @json["data"]
    if @info.save
      render json: @info, status: :created
    else
      render json: @info.errors, status:  :unprocessable_entity
    end
  end


  def update
    if @info.update(info_params)
      render json: @info, status: :ok
    else
      render json: @info.errors, status: :unprocessable_entity
    end
  end

  
  def destroy
    if @info.destroy
      render json: { status: :ok }
    else
      render json: @info.errors, status: :unprocessable_entity
    end
  end


  private

  def set_json
    @json = JSON.parse(request.body.read)
  end

  def set_info
    @info = UserInfo.find(params[:id])
  end

  def info_params
    params.require(:user_info).permit(:profile_id, :access_level, :data => {})
  end
end
