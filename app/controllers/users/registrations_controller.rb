# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super do |user|
      if current_user&.admin?
        if user.persisted? 
          redirect_to users_path, notice: "User was successfully created."
        else
          render :new
        end
        return
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    @user = User.find(params[:format])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end

 
  # protected


  def require_no_authentication
    super unless current_user&.admin?
  end
end
