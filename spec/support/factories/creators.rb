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
    icon { uploaded_sample_image }

    trait :with_site do |creator|
      creator.creator_sites << build(:creator_site) if creator.creator_sites.blank?
    end
  end
end
