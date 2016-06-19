require 'rails_helper'

RSpec.describe "tunes/index", type: :view do
  before(:each) do
    assign(:tunes, [
      Tune.create!(),
      Tune.create!()
    ])
  end

  it "renders a list of tunes" do
    render
  end
end
