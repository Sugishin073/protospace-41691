class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototype = current_user
  end
end
