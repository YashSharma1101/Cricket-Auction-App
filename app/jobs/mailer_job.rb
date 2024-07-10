# app/jobs/mailer_job.rb
class MailerJob < ApplicationJob
  queue_as :default

  def perform(user)
    begin
      AuctionMailer.player_report(user).deliver_now
    rescue => e
      Rails.logger.error("Failed to send email to #{user.email}: #{e.message}")
    end
  end
end
