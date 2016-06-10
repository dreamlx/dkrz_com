require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it "is valid" do
    expect(create(:feedback)).to be_valid
  end
end
