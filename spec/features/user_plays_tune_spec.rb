require 'rails_helper'

feature 'User plays tune' do
  before(:all) do
    Tune.delete_all
    FactoryGirl.create(:tune)
    visit tunes_path
  end



  scenario 'with tune with correct youtube video id' do
    within(:css, '.video-container') do
      find(:css, '.play-button').click
      expect(page).to have_css('.video')
    end
  end

  # scenario 'with invalid email' do
  #   sign_up_with 'invalid_email', 'password'

  #   expect(page).to have_content('Sign in')
  # end

  # scenario 'with blank password' do
  #   sign_up_with 'valid@example.com', ''

  #   expect(page).to have_content('Sign in')
  # end

  # def sign_up_with(email, password)
  #   visit sign_up_path
  #   fill_in 'Email', with: email
  #   fill_in 'Password', with: password
  #   click_button 'Sign up'
  # end
end
