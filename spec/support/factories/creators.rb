# == Schema Information
#
# Table name: creators
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  profile    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :creator do
    name { 'ケロ' }
    profile { 'yorozu no mono wo tsukurikeri.' }
    icon { Rack::Test::UploadedFile.new('spec/support/files/icon.png', 'image/png') }
  end
end
