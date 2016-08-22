class Api::V1::UserInfosController < ApplicationController

  
  def show
    respond_to do |format|
      format.json {render json: "test", status: 200}
    end
  end
  
  def create
    body = request.body.string
      res = JSON.parse(body)
    res["user_info"].each do |key, value|
      info = UserInfo.new
      info.key = key
      info.value = value
      info.save
    end

  end

  def edit
    
  end

  
  def destroy
    
  end

  private
  def info_params
    params.require(:userinfo).permit(:key, :value, :access_level, :profile_id)
  end
end
