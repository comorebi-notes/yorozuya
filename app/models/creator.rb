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
  has_one_attached :icon

  ICON_SIZES = { large: '800x800', default: '256x256', thumb: '128x128' }.freeze

  validates :name, presence: true
end
