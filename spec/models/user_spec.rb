require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    expect(create(:user)).to be_valid
  end

  it "length of user number is 6" do
    user = create(:user)
    expect(user.number.length).to eq 6
  end
end
