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
FactoryBot.define do
  factory :work do
    title { '作品' }
    status { :published }
    slug { 'work_slug' }
    release_date { Time.zone.today }
    description { 'これはこういった作品です。' }
    content { '以上、こういった作品でした。' }
    like { 1000 }
    eye_catch { uploaded_sample_image }

    after :build do |work|
      work.work_creators << build(:work_creator, work: work, creator: create(:creator)) if work.work_creators.blank?
    end
  end
end
