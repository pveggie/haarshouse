require 'rails_helper'

RSpec.describe "tunes/edit", type: :view do
  before { @tune = assign(:tune, FactoryGirl.build_stubbed(:tune)) }

  it "renders the edit tune form" do
    render
    assert_select "form[action=?][method=?]", tune_path(@tune), "post"
  end
end
