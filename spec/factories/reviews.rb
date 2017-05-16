FactoryGirl.define do
  factory :review do
    sequence(:body) {|n| "review #{n}, this amplifier sounds great!"}

    association :amplifier, factory: :amplifier
    association :user, factory: :user
  end
end
