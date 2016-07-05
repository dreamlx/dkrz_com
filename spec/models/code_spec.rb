require 'rails_helper'

RSpec.describe Code, type: :model do
  it "is valid" do
    expect(create(:code)).to be_valid
  end
end
