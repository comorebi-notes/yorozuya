FactoryBot.define do
  factory :work_creator do
    role { :composer }
    xorder { 1 }
    creator { nil }
    work { nil }
  end
end
