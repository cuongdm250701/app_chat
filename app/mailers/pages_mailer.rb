class PagesMailer < ApplicationMailer
    def send_mail(page, receiver)
      @page = page
      mail(to: receiver, subject: "Review App Chat From To Cuong.DM")
    end
end
