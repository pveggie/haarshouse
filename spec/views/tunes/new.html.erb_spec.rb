require 'rails_helper'

RSpec.describe "tunes/new", type: :view do
  before(:each) do
    assign(:tune, Tune.new())
  end

  it "renders new tune form" do
    render

    assert_select "form[action=?][method=?]", tunes_path, "post" do
    end
  end
end
