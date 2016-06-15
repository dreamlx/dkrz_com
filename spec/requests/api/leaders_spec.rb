require 'rails_helper'

RSpec.describe "leaders" do
  describe "POST #create" do
    it "create a new leader" do
      Leader.delete_all
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      valid_attributes = attributes_for(:leader)
      post "/api/leaders", {leader: valid_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      leader = Leader.first
      expect(leader.user_id).to eq user.id
      ["name", "phone", "sex", "workplace", "income", "payoff_type", "job", "has_credit_card", "loan_experience", "mortgage", "has_car_loan", "has_accumulation_fund", "has_life_insurance", "channel"].each do |item|
        expect(leader.send(item)).to eq valid_attributes[:"#{item}"]
      end
      expect(leader.birth.to_s).to eq valid_attributes[:birth].to_s
    end

    it "failed to create leader without user" do
      valid_attributes = attributes_for(:leader)
      post "/api/leaders", {leader: valid_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end
end