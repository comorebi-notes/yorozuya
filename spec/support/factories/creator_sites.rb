# == Schema Information
#
# Table name: creator_sites
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  type       :integer          default("general"), not null
#  url        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :bigint           not null
#
# Indexes
#
#  index_creator_sites_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => creators.id)
#
FactoryBot.define do
  factory :creator_site do
    name { 'ホームページ' }
    kind { :general }
    url { 'https://example.com' }

    association :creator
  end
end
