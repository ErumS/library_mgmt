FactoryGirl.define do
  factory :member do
    name Faker::Name.name
    address Faker::Address.street_address
    phone_no "6457439539"
    gender ["Male", "Female"]
    code Faker::Code.ean
    validity_date Faker::Date.between(9.days.ago, Date.today)
    is_author ['True', 'False']
    association :library, factory: :library, strategy: :create
  end
end