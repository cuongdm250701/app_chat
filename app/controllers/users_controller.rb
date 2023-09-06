class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def change_password;end

  def update_password
    user = User.find(current_user[:id])
    if user.valid_password?(params[:password])
      user.update_attributes(password: params[:password_confirmation], is_changed_pass: false)
      redirect_to root_path
    else
      redirect_to profile_change_password_path, notice: "Password is valid !"
    end
  end

end
