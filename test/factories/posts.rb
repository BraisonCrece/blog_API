FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { [true,false].sample }
    user { FactoryBot.create(:user) }
  end
end
