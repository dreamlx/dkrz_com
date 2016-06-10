FactoryGirl.define do
  factory :feedback do
    association :user
    content "MyString"
  end
end
