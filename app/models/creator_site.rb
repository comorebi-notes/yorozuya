# == Schema Information
#
# Table name: creator_sites
#
#  id         :bigint           not null, primary key
#  kind       :integer          default("general"), not null
#  name       :string(255)      not null
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
class CreatorSite < ApplicationRecord
  belongs_to :creator

  enum kind: { general: 0, homepage: 1, email: 2,
               twitter: 10, facebook: 11, instagram: 12,
               youtube: 20, niconico: 21, soundcloud: 22, pixiv: 23 }

  validates :name, presence: true
  validates :kind, presence: true
  validates :url,  presence: true
end
