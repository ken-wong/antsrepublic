FactoryGirl.define do
  factory :queen_product_relationship do
    association :user
    association :product
  end
end
