FactoryBot.define do
  factory :work do
    title { '作品' }
    status { :published }
    slug { 'work_slug' }
    description { 'これはこういった作品です。' }
    content { '以上、こういった作品でした。' }
    like { 100 }
  end
end
