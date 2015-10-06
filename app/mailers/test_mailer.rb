class TestMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = Figaro.env.DOMAIN_NAME
    mail(to: user.email) do |format|
      format.html { render 'welcome_email' }
      format.text
    end
  end
end
