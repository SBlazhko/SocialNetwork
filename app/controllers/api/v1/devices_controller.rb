class Api::V1::DevicesController < ApplicationController

  api :POST, 'profile/push', "Enable or disable push notification"
  formats ['json']
  param :profile_id, :number, required: true
  param :device, ['android', 'ios']
  param :enabled, ['true', 'false'], "default true", required: true
  example DeviceHelper.push_enabled
  def push_enabled
    @devise = Device.where(profile_id: params[:profile_id], platform: params[:platform])
    @devise.enabled = params[:enabled]
    if @devise.save
      render json: { "message": "successfully" }, status: :ok
    else
      render json: { errors: @devise.errors }, status: :unprocessable_entity
    end
  end

  api :POST, 'profile/send_push', "Create a device token"
  formats ['json']
  param :profile_id, :number, required: true
  param :token, String, required: true
  param :platform, ['android', 'ios'], required: true
  def create
    @device = Device.new(device_params)
    if @device.save
      render json: { device: @devise }, status: :ok
    else
      render json: { errors: @device.errors }, status: :unprocessable_entity
    end
  end

  private
  def device_params
    params.require(:device).permit(:profile_id, :token, :platform, :enabled)
  end
end
