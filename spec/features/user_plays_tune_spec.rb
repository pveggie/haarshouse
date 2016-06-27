require 'rails_helper'

feature 'User plays tune' do
  before(:all) do
    Tune.delete_all
    FactoryGirl.create(:tune)
  end

  it "adds a youtube iframe when play button is clicked", js: true do
    visit tunes_path
    within(:css, '.video-container') do
      expect(page).to_not have_css('iframe')
      find(:css, '.play-button').click
      expect(page).to have_css('iframe')
      # p find(:css, 'a', match: :first)
    end
  end

  scenario 'with tune having valid youtube video id', js: true do


    # p has_content?('Rayman Legends OST')
    # expect(page).to have_content('Rayman Legends OST')

  end

  # scenario 'with invalid email' do
  #   sign_up_with 'invalid_email', 'password'

  #   expect(page).to have_content('Sign in')
  # end

  # scenario 'with blank password' do
  #   sign_up_with 'valid@example.com', ''

  #   expect(page).to have_content('Sign in')
  # end

  # def play_video
  #   visit sign_up_path
  #   fill_in 'Email', with: email
  #   fill_in 'Password', with: password
  #   click_button 'Sign up'
  # end
end
