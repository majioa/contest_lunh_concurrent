FactoryGirl.define do
  factory :payment do
    association :service, factory: :service
  end
end
