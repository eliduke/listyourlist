FactoryGirl.define do

  factory :item do
    body { Faker::Lorem.word }
  end

end