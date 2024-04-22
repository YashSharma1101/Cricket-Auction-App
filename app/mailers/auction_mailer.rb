class AuctionMailer < ApplicationMailer
  def player_report(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to TCL - Your Auction Report')
  end
end
