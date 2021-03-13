# == Schema Information
#
# Table name: works
#
#  id           :bigint           not null, primary key
#  content      :text(65535)
#  description  :text(65535)
#  like         :integer          default(0), not null
#  release_date :date             not null
#  slug         :string(255)      not null
#  status       :integer          default("draft"), not null
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  work_id      :bigint
#
# Indexes
#
#  index_works_on_slug     (slug) UNIQUE
#  index_works_on_work_id  (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (work_id => works.id)
#
class Work < ApplicationRecord
  EYE_CATCH_SIZES = { large: [1920, 1008], default: [1200, 630], thumb: [200, 105] }.freeze

  has_one_attached :eye_catch

  belongs_to :parent, class_name: 'Work', foreign_key: :work_id, optional: true, inverse_of: :parent

  has_many :children, class_name: 'Work', dependent: :nullify, inverse_of: :parent
  has_many :work_creators, -> { order(:role).order(:xorder) }, dependent: :destroy, inverse_of: :work
  has_many :creators, through: :work_creators

  accepts_nested_attributes_for :work_creators, reject_if: :all_blank, allow_destroy: true

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true
  validates :status, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :release_date, presence: true
  validates :like, presence: true
  validates :work_creators, length: { minimum: 1 }

  def to_param = slug
end
