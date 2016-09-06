require 'rails_helper'

RSpec.feature 'Tune playback' do
  background do
    create(:tune)
  end

  scenario "loading a youtube video by clicking the play button", js: true do
    visit tunes_path

    within(:css, '.video-container') do
      expect(page).to_not have_css('iframe')
      find(:css, '.play-button').click
      expect(page).to have_css('iframe')
    end
  end
end
