FactoryGirl.define do
  factory :queen do
    email "MyString"
    name "MyString"
    cell "MyString"
    avatar File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    password "foobar"
    password_confirmation "foobar"
  end
end
