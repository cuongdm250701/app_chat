class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource

  def new
    if current_user&.admin?
      @groups = Group.all
    end
    super
  end

  def create
    if current_user&.admin?
      ActiveRecord::Base.transaction do
        @user = User.new(sign_up_params)
        if @user.save
          if params[:user][:group_ids].present?
            group_ids = params[:user][:group_ids]
            @user.groups << Group.where(id: group_ids)
          end
          redirect_to users_path, notice: "User was successfully created."
        else
          @groups = Group.all
          render :new
        end
      end
    else 
      super
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
