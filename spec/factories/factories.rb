FactoryGirl.define do
  factory :article do
    user
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
  end

  factory :comment do
    article
    user
    body { Faker::Lorem.paragraph }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.words(5).join }
  end

  factory :vote do
    user
    association :votable, factory: :article
    direction { ['up', 'down'].sample }
  end
end
