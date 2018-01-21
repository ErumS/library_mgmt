FactoryGirl.define do
  factory :book do
    name Faker::Book.title
    code Faker::Code.isbn
    author Faker::Book.author
    price Faker::Number.positive
    publication Faker::Book.publisher
    version Faker::Number.between(1, 10)
    association :library, factory: :library, strategy: :create
    association :category, factory: :category, strategy: :create
    association :member, factory: :member, strategy: :create
  end
end