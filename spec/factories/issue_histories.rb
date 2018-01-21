FactoryGirl.define do
  factory :issue_history do
    issue_date Faker::Date.between(19.days.ago, Date.today)
    return_date Faker::Date.between(9.days.ago, Date.today)
    copies Faker::Number.between(1,3)
    association :member, factory: :member, strategy: :create
  end
end