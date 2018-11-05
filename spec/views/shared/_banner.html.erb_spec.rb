require 'rails_helper'

RSpec.describe 'shared/_banner', type: :view do
  describe 'Navigation' do
    context 'while logged out' do
      before do
        render partial: 'banner.html.erb', locals: { haar_joke: 'test text' }
      end

      it 'renders the login icon' do
        expect(rendered).to match(/Login/)
      end

      it 'does not render a profile link' do
        expect(rendered).to_not match(/Profile/)
      end

      it 'does not render a logout link' do
        expect(rendered).to_not match(/Logout/)
      end
    end

    context 'while logged in' do
      before do
        @user = assign(:user, create(:user))
        sign_in @user
        render partial: 'banner.html.erb', locals: { haar_joke: 'test text' }
      end

      it 'does not render the login icon' do
        expect(rendered).to_not match(/Login/)
      end

      it 'renders a logout link' do
        expect(rendered).to match(/Logout/)
      end
    end
  end
end
