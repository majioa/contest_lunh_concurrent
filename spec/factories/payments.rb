FactoryGirl.define do
  factory :payment do
    association :service, factory: :service
    association :line_item, factory: :line_item
  end
end
