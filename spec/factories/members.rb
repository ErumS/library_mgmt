FactoryGirl.define do
  factory :member do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no Faker::PhoneNumber.cell_phone
    gender ["Male", "Female"]
    code Faker::Code.ean
    validity_date Faker::Date.between(9.days.ago, Date.today)
    is_author ['True', 'False']
  end
end