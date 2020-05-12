class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :is_current_user? , only: [:show]
  def show

    @user = User.find(params[:id])
  end

  private
  def is_current_user?
    unless current_user == User.find(params[:id])
      redirect_to root_path
    end
  end
end
