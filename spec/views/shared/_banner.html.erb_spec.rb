require 'rails_helper'

RSpec.describe 'shared/_banner', type: :view do
  describe "Navigation" do

    context "while logged out" do
      it "renders the login icon" do
        render partial: 'banner.html.erb', locals: { haar_joke: "test text" }
        expect(rendered).to match /Login/
      end

      it "does not render a profile link" do
      end

      it "does not render a logout link" do
      end
    end
  end
end