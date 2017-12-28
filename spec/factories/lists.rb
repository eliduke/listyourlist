FactoryGirl.define do

  factory :list do
    user_id 1
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    ordered false
    public true

    trait :unpublic do
      public false
    end

    trait :ordered do
      ordered true
    end
  end

end