FactoryGirl.define do
  factory :category do
    department Faker::Commerce.department
  end
end