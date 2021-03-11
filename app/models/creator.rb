# == Schema Information
#
# Table name: creators
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  profile    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Creator < ApplicationRecord
  ICON_SIZES = { large: '800x800', default: '256x256', thumb: '128x128' }.freeze

  has_one_attached :icon

  has_many :creator_sites, dependent: :destroy

  accepts_nested_attributes_for :creator_sites, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
