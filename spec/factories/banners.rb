FactoryGirl.define do
  factory :banner do
    title "MyString"
    image File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    state "active"
  end
end
