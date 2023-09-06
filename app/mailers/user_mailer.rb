class UserMailer < ApplicationMailer
    def send_mail(user)
        @user = user
        mail(to: user.email, subject: "Nofity Change Password")
    end
end
