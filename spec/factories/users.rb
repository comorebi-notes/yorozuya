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
FactoryBot.define do
  factory :user do
    name { 'Test user' }
    password { 'P@ssw0rd' }
    password_confirmation { 'P@ssw0rd' }

    sequence(:screen_name) { |n| "login_id_#{n}" }
  end
end
