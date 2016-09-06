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

  def device_push_token_create(profile_id, push_token, paltform)
    @device = Device.create(profile_id: profile_id, token: token, paltform: paltform)
    if @device.save
      true
    else
      false
    end
  end

  def device_push_token_destroy()

  end

  private
  def device_params
    params.require(:device).permit(:profile_id, :token, :platform, :enabled)
  end
end
