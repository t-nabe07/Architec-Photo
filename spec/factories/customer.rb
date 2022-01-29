FactoryBot.define do
  factory :customer do
    email                 { Faker::Internet.free_email }
    password              { 'aaBB1234' }
    password_confirmation { password }
    first_name            { '田中' }
    last_name             { '太郎' }
    first_name_kana       { 'タナカ' }
    last_name_kana        { 'タロウ' }
    college_name          { '日本大学' }
  end
end
