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
