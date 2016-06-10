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
