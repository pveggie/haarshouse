require 'rails_helper'

RSpec.describe "tunes/index", type: :view do
  before do
    assign(
      :tunes, [build_stubbed(:tune), build_stubbed(:tune)]
    )
  end

  it "renders a list of tunes" do
    render
  end
end
