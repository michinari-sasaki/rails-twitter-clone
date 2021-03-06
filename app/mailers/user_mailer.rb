class UserMailer < ApplicationMailer

  def account_activation(user)
    @greeting = "ここにテキストをいれられる"
    @user = user
    mail to: @user.email,
    subject: "Account activation"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
