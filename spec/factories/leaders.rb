FactoryGirl.define do
  factory :leader do
    name "MyString"
    phone "MyString"
    sex "man"
    birth "2016-06-11"
    workplace "Shanghai"
    income "1000"
    payoff_type "银行转账发款"
    job "MyString"
    has_credit_card "MyString"
    loan_experience "MyString"
    mortgage "MyString"
    has_car_loan "YES"
    has_accumulation_fund "MyString"
    has_life_insurance "YES"
    
    association :user
  end
end
