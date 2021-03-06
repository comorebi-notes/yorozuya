# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  remember_token  :string(255)
#  screen_name     :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_screen_name  (screen_name) UNIQUE
#
class User < ApplicationRecord
  has_secure_password validations: true

  validates :screen_name, presence: true, uniqueness: true

  def self.new_remember_token = SecureRandom.urlsafe_base64

  def self.encrypt(token) = Digest::SHA256.hexdigest(token.to_s)
end
