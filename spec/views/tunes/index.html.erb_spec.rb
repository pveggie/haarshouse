require 'rails_helper'

RSpec.describe "tunes/index", type: :view do
  before do
    assign(:tunes, [
      FactoryGirl.build_stubbed(:tune), FactoryGirl.build_stubbed(:tune)
    ])
  end

  it "renders a list of tunes" do
    render
  end
end
