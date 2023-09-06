# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_active_account, only: [:create]
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    # binding.pry
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_out_path_for(resource_name)
    signin_path
  end

  protected


 
  def check_active_account
    user = User.where(email: params[:user][:login]).or(User.where(username: params[:user][:login]))
    if user[0].deactived
      raise StandardError
    end
  end
end
