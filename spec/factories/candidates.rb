FactoryBot.define do
  factory :candidate do
    age { 25 }
    # birth_date {Faker::Date.between(from: '1930-01-01', to: '2016-12-31')}
    birth_date {'2000-12-12'}
    gender_id { 1 }
    experience_id { 1 }
    birth_place { '東京都'}
    political_party { '共和党' }
    education { 'アメリカン大学' }
    occupation { '自営業' }

    transient do
      person { Gimei.name }
    end
  
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    association :electorate
  end
end
