class Api::V1::SessionsController < ApplicationController

  def create
    profile = Profile.find_by(login: create_params[:login])
    if user && profile.authenticate(create_params)
      self.current_user = user
      render(
        status: 201
      )
    else
      return api_error(status: 401)
    end
  end

  private
  def create_params
    params.require(:profiles).permit(:login, :password)
  end
end
