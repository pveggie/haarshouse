require 'rails_helper'

RSpec.feature 'Tune playback', playing: true do
  background do
    create(:tune, views: 12)
  end

  scenario "clicking the play button loads a youtube video", js: true do
    visit tunes_path

    within(:css, '.video-container') do
      expect(page).to_not have_css('iframe')
      find(:css, '.play-button').trigger('click')
      expect(page).to have_css('iframe')
    end
  end

  scenario "the displayed view count is increased by one upon play", js: true do
    visit tunes_path

    within(:css, '.video-container') do
      within(:css, '.caption-views') do
        expect(page).to have_content(' 12')
      end

      find(:css, '.play-button').trigger('click')

      within(:css, '.caption-views') do
        expect(page).to have_content(' 13')
      end
    end
  end
end
