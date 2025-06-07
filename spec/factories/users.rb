FactoryBot.define do
  Faker::Config.locale = :ja

  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { 'test1234' }
    password_confirmation { 'test1234' }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        { 'ヤマダ' }  
    first_name_kana       { 'タロウ' }   
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
