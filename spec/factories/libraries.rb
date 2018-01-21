FactoryGirl.define do
  factory :library do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no "65739264094"
  end
end