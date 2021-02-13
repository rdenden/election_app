FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    association :electorate
    association :room
  end
end
