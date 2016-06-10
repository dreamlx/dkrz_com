require 'rails_helper'

RSpec.describe "users" do
  describe "GET #show" do
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
  end
end