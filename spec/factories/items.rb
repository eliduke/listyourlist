FactoryGirl.define do

  factory :item do
    list { create(:list) }
    body { Faker::Lorem.word }
  end

end