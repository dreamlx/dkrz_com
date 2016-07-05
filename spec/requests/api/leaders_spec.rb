require 'rails_helper'

RSpec.describe "leaders" do
  describe "POST #create" do
    it "create a new leader" do
      Leader.delete_all
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      valid_attributes = {
        "channel"=>"001", 
        "name"=>"杨柳", 
        "phone"=>"13563312989", 
        "sex"=>"1", 
        "workplace"=>"山东日照东港区", 
        "birth"=>"1995/10/10", 
        "income"=>"3000", 
        "hasCreditCard"=>"Y", 
        "mortgage"=>"Y", 
        "loanExperience"=>"是", 
        "profession"=>"0", 
        "payoffType"=>"0", 
        "applyDate"=>"2016-07-06 02:30:41"
      }
      post "/api/leaders", valid_attributes, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      leader = Leader.first
      expect(leader.user_id).to eq user.id
      ["name", "phone", "sex", "workplace", "income", "mortgage", "channel"].each do |item|
        expect(leader.send(item)).to eq valid_attributes[item]
      end
      expect(leader.birth.to_date).to eq valid_attributes["birth"].to_date
      expect(leader.has_credit_card).to eq valid_attributes["hasCreditCard"]
      expect(leader.loan_experience).to eq valid_attributes["loanExperience"]
      expect(leader.job).to eq valid_attributes["profession"]
      expect(leader.payoff_type).to eq valid_attributes["payoffType"]
    end

    it "failed to create leader without user" do
      valid_attributes = attributes_for(:leader)
      post "/api/leaders", {leader: valid_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

  describe "GET #get_serial_number" do
    it "get serial_number" do
      get "/api/get_serial_number"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["serial_number"]).to be_a(Integer)
    end
  end
end