FactoryGirl.define do
  factory :book do
    name Faker::Book.title
    code Faker::Code.isbn
    author Faker::Book.author
    price Faker::Number.positive
    publication Faker::Book.publisher
    version Faker::Number.between(1, 10)
  end
end