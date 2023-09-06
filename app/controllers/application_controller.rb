class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |execption|
       redirect_to root_path, alert: "Permission denied"
    end

    rescue_from StandardError, with: :handle_error


    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, 
           keys: [:username, :name, :email, :password, :password_confirmation, group_ids: []]
        )

        devise_parameter_sanitizer.permit(:sign_in,
           keys: [:login, :password, :password_confirmation]
        )

        devise_parameter_sanitizer.permit(:account_update,
           keys: [:username, :name, :email, :password_confirmation, :current_password]
        )
    end

    private

    def handle_error(exception)
        redirect_to new_user_session_path, notice: "Account was deactived"
    end
end
