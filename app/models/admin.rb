# app/models/admin.rb
class Admin < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def update_last_seen
    self.update_column(:last_seen, Time.current)
  end
end
