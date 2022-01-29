FactoryBot.define do
  factory :production do
    title { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:30) }
    after(:build) do |production|
      production.images.attach(io: File.open('spec/fixtures/test.jpg'), filename: 'test.jpg', content_type: 'image/ipg')
    end
  end
end