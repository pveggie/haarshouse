require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:test_user) { build(:user) }

  describe "Active record associations" do
    it { expect(test_user).to have_many(:tunes) }
  end
end
