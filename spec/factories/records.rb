FactoryGirl.define do
  factory :record do
    user nil
    amount "9.99"
    recordable nil
    from_amount "9.99"
    to_amount "9.99"
    date "2016-06-15"
    desc "MyString"
  end
end
