require 'rails_helper'

RSpec.describe "tunes/edit", type: :view do
  before(:each) do
    @tune = assign(:tune, FactoryGirl.build_stubbed(:tune))
  end

  it "renders the edit tune form" do
    render
    assert_select "form[action=?][method=?]", tune_path(@tune), "post"
  end
end
