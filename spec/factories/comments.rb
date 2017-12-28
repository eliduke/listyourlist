FactoryBot.define do

  factory :comment do
    user_id 1
    list_id 1
    body { Faker::Lorem.paragraph }
  end

end
