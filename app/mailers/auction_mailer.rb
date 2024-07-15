class AuctionMailer < ApplicationMailer
  def player_report(user)
    attachments.inline['ilead.png'] = File.read(Rails.root.join('app/assets/images/ilead.png'))
    @user = user
    mail(to: @user.email, subject: 'Welcome to iLead Cricket League - Your Auction Report')
  end
end
