FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com" }
  sequence(:name) {|n| "user#{n}" }
  
  factory :user do
    name "user1"
    email "sample@example.com"
    password "password1"
    password_confirmation "password1"
  end
end