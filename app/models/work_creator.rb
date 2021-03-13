# == Schema Information
#
# Table name: work_creators
#
#  id         :bigint           not null, primary key
#  guest      :boolean          default(FALSE), not null
#  name       :string(255)
#  role       :integer          default("author"), not null
#  xorder     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :bigint
#  work_id    :bigint           not null
#
# Indexes
#
#  index_work_creators_on_creator_id  (creator_id)
#  index_work_creators_on_work_id     (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => creators.id)
#  fk_rails_...  (work_id => works.id)
#
class WorkCreator < ApplicationRecord
  belongs_to :creator, optional: true
  belongs_to :work

  enum role: { author: 0,
               vocal: 10, chorus: 11, composer: 12, lyricist: 13, arranger: 14, mixer: 15, mastering: 16,
               illustrator: 20, video: 21,
               comic: 30, story: 31, drawer: 32,
               designer: 40, programmer: 41, planner: 42 }

  validates :name, presence: true, if: :guest?
  validates :name, absence: true, unless: :guest?
  validates :creator_id, absence: true, if: :guest?
  validates :creator_id, presence: true, unless: :guest?
  validates :role, presence: true
  validates :xorder, presence: true
end
