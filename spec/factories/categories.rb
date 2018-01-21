FactoryGirl.define do
  factory :category do
    department Faker::Commerce.department
    association :library, factory: :library, strategy: :create
  end
end