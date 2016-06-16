require 'rails_helper'

RSpec.describe "users" do
  describe "GET #get_info" do
    it "get user info with openid" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      get "/api/users/get_info", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["user"]
      expect(json["avatar_thumb"]).to eq user.avatar_url(:thumb)
      expect(json["number"]).to eq user.number
      expect(json["name"]).to eq user.name
      expect(json["cell"]).to eq user.cell
      expect(json["email"]).to eq user.email
      expect(json["id_card"]).to eq user.id_card
      expect(json["bank_card"]).to eq user.bank_card
      expect(json["alipay"]).to eq user.alipay
    end

    it "create a user with openid" do
      User.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("openid")
      }
      get "/api/users/get_info", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["user"]
      user = User.first
      expect(user.openid).to eq "openid"
      expect(user.number).to eq json["number"]
      expect(user.number).not_to be_nil
    end
  end

  describe "GET #get_qrcode" do
    it "get user's qrcode url" do
      user = create(:user)
      user.save
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      get "/api/users/get_qrcode", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["qrcode_url"]).to eq user.qrcode_url
      expect(user.qrcode_url).not_to be_nil
    end

    it "get user's qrcode url with user creation" do
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("openid")
      }
      get "/api/users/get_qrcode", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["qrcode_url"]).not_to be_nil
    end
  end

  describe "GET #get_invite_code" do
    it "get user's invite code" do
      user = create(:user)
      user.save
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      get "/api/users/get_invite_code", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["invite_code"]).to eq user.number
    end
  end

  describe "GET #set_superior" do
    it "set superior" do
      Record.delete_all
      superior = create(:user)
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      balance = user.balance
      get "/api/users/set_superior", {invite_code: superior.number}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      user.reload
      expect(user.superior_id).to eq superior.id
      expect(user.balance).to eq balance + 400
      record = user.records.first
      expect(record.from_amount).to eq balance
      expect(record.to_amount).to eq balance + 400
      expect(record.amount).to eq 400
      expect(record.date).to eq Date.today
      expect(record.desc).to eq "新手红包"
    end

    it "failed to set superior if had been set" do
      superior = create(:user)
      user = create(:user)
      user.update(superior_id: superior.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      balance = user.balance
      get "/api/users/set_superior", {invite_code: superior.number}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq "请不要重复绑定"
    end

    it "failed to set superior if invite code not valid" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      get "/api/users/set_superior", {invite_code: "invalid_invite_code"}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq "无效邀请码"
    end
  end

  describe "PATCH #update_profile" do
    it "update user's profile" do
      user = create(:user, avatar: nil)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      new_attributes = {
        name: "new name",
        cell: "11111111111",
        email: "foobar@example.com",
        id_card: "new id card",
        bank_card: "new bank card",
        alipay: "new alipay",
        avatar: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read)
      }
      patch "/api/users/update_profile", {user: new_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["user"]
      expect(json["name"]).to eq new_attributes[:name]
      expect(json["cell"]).to eq new_attributes[:cell]
      expect(json["email"]).to eq new_attributes[:email]
      expect(json["id_card"]).to eq new_attributes[:id_card]
      expect(json["bank_card"]).to eq new_attributes[:bank_card]
      expect(json["alipay"]).to eq new_attributes[:alipay]
      user.reload
      expect(json["avatar_thumb"]).to eq user.avatar_url(:thumb)
      expect(user.avatar).not_to be_nil
    end
  end

  describe "GET #get_balance" do
    it "get user's balance" do
      user = create(:user)
      user.save
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      get "/api/users/get_balance", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["balance"]).to eq user.balance.to_s
    end
  end

  describe "GET #commissions" do
    it "get the commissions info" do
      user = create(:user, commission: 10, second_commission: 20, third_commission: 30)
      user.save
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      leader = create(:leader, user_id: user.id, amount: 10.0)
      get "/api/users/commissions", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["commission"]).to eq 10.to_d.to_s
      expect(json["second_commission"]).to eq 20.to_d.to_s
      expect(json["third_commission"]).to eq 30.to_d.to_s
      expect(json["total_commission"]).to eq 60.to_d.to_s
      expect(json["leader_count"]).to eq 1
      expect(json["today_leader_count"]).to eq 1
      expect(json["total_amount"]).to eq 10.to_d.to_s
    end
  end

  describe "GET #subordinates" do
    it "get subordinate info" do
      user = create(:user, commission: 10, second_commission: 20, third_commission: 30)
      user.save
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      subordinate = create(:user, superior_id: user.id)
      lower_subordinate = create(:user, superior_id: subordinate.id)
      get "/api/users/subordinates", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["subordinate_count"]).to eq 1
      expect(json["lower_subordinate_count"]).to eq 1
      expect(json["subordinate_amount"]).to eq 0.to_d.to_s
      expect(json["commission"]).to eq 10.to_d.to_s
      expect(json["second_commission"]).to eq 20.to_d.to_s
      expect(json["third_commission"]).to eq 30.to_d.to_s
    end
  end
end