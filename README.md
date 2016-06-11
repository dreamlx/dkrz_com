## 获取借贷员个人信息
```
curl -X GET --header "Authorization: Token token=#{openid}" http://localhost:3000/api/users/get_info
```
```
{
  "user"=>
  {
    "avatar_thumb"=>"/uploads/user/avatar/31/thumb_rails.png", 
    "number"=>"349388", 
    "name"=>"MyString", 
    "cell"=>"11111111111", 
    "email"=>"foobar4@example.com", 
    "id_card"=>"MyString", 
    "bank_card"=>"MyString", 
    "alipay"=>"MyString"
  }
}
```
## 意见反馈
```
curl -X POST -d "content=xxx" --header "Authorization: Token token=#{openid}" http://localhost:3000/api/feedbacks
```
```
status is 200 if ok, else 422 or 401
```
## 创建借贷人
```
curl -X POST -d "#{below}" --header "Authorization: Token token=#{openid}" http://localhost:3000/api/leaders
```
```
params: {
          "name"=> "foobar"
          "phone"=> "11111111111",
          "sex"=> "man",
          "birth"=> "2016-06-11",
          "workplace"=>"Shanghai",
          "income"=>"8000元以上",
          "payoff_type"=>"银行转账发薪",
          "job"=>"IT",
          "has_credit_card"=> "yes",
          "loan_experience"=> "yes",
          "mortgage"=>"yes",
          "has_car_loan"=>"yes",
          "has_accumulation_fund"=>"yes",
          "has_life_insurance"=>"yes"
        }
response: status is 200 if ok, else 422 or 401
```
