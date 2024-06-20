# # app/models/user.rb

# class User < ApplicationRecord
#   require 'csv'
#   require 'open-uri'

#   serialize :photo, JSON

#   has_one_attached :photo_attachment

#   def self.import(file)
#     CSV.foreach(file.path, headers: true) do |row|
#       user = User.new(row.to_hash.except('photo'))
#       download_and_attach_image(user, row['photo']) if row['photo'].present?
#       user.save!
#     end
#   end

#   private

#   def self.download_and_attach_image(user, photo_url)
#   	byebug
#     io = URI.open(photo_url)
#     user.photo_attachment.attach(io: io, filename: 'photo.jpg')
#     io.close
#   end
# end
# app/models/user.rb

# class User < ApplicationRecord
#   require 'csv'

#   # has_one_attached :photo

#   def self.import(file)
#     CSV.foreach(file.path, headers: true) do |row|
#       user = User.new(row.to_hash)
#       # user.photo.attach(io: File.open(row['photo']), filename: 'photo.jpg') if row['photo'].present?
#       user.save!
#     end
#   end
# end

# app/models/user.rb

# class User < ApplicationRecord
#   require 'csv'

#   has_one_attached :photo_attachment

#   def self.import(file)
#     CSV.foreach(file.path, headers: true) do |row|
#       user = User.new(row.to_hash.except('photo'))
#       user.save!
#     end
#   end

#   # Allow mass assignment for photo_attachment
#   attr_accessor :photo_attachment
# end

# app/models/user.rb

class User < ApplicationRecord
  require 'csv'
  # belongs_to :team, foreign_key: 'team', primary_key: 'name', optional: true
  has_one_attached :photo_attachment

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = User.new(row.to_hash.except('photo'))
      user.save!
    end
  end

   def send_mail
    byebug
    # @user = User.all
    # @user.each do |user| 
      user = User.find_by(email: "yashsharma0787@gmail.in")
      byebug
      if user.price == 0 && user.email.present?
        AuctionMailer.player_report(user).deliver_later
      end
    # end
  end
end


