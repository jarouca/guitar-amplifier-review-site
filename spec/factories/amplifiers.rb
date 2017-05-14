FactoryGirl.define do
  factory :amplifier do
    sequence(:manufacturer) { |n| "Fender #{n}" }
    sequence(:model) { |n| "Princeton #{n}" }
    speaker "Jensen 8 inch alnico"
    tube_set "5y3, 6v6, 12ax7"

    association :user, factory: :user
  end
end
