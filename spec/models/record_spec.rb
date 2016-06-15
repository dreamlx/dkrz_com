require 'rails_helper'

RSpec.describe Record, type: :model do
  it "is valid" do
    expect(create(:record)).to be_valid
  end
end
