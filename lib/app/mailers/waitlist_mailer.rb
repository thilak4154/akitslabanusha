class WaitlistMailer < ApplicationMailer
  default from: 'libsys.ncsu@gmail.com'

  def waiting_clear_notification(user,book)
    @user = user
    @book = book
    @url = ' http://52.23.207.210:4000/'
    mail(to: @user.email, subject: 'LibSys: Waitlist Cleared')
  end
end
