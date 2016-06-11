require 'rails_helper'

RSpec.describe Leader, type: :model do
  it "is valid" do
    expect(create(:leader)).to be_valid
  end
end
