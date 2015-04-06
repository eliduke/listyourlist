FactoryGirl.define do

  factory :list do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    ordered false
    published true

    trait :unpublished do
      published false
    end

    trait :ordered do
      ordered true
    end
  end

end