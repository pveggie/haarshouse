require 'rails_helper'

RSpec.describe "tunes/show", type: :view do
  before(:each) do
    @tune = assign(:tune, Tune.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
