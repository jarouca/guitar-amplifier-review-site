FactoryGirl.define do
  factory :vote do

    association :user, factory: :user
    association :review, factory: :review
  end
end
