class AuctionMailer < ApplicationMailer
  def player_report(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to iLead Cricket League - Your Auction Report')
  end
end
