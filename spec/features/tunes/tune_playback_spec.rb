require 'rails_helper'

RSpec.feature 'Tune playback', playing: true, viewing: true do
  background do
    create(:tune, views: 12)
  end

  scenario 'clicking the play button loads youtube iframe', js: true do
    visit tunes_path

    within(:css, '.video-container') do
      expect(page).to have_css('.video')
      expect(page).to_not have_css('iframe')

      find(:css, '.play-button').click

      expect(page).to have_css('iframe')
    end
  end

  scenario 'youtube video loads within iframe', js: true do
    visit tunes_path

    within(:css, '.video-container') do
      find(:css, '.play-button').click
    end

    within_frame 'dSCq7jTL7tQ' do
      expect(page).to have_css('html')
      # Following text is from YouTube video itself, so it will break
      # if the song is renamed or deleted on youtube.
      expect(page).to have_content('Dragon Age II Soundtrack')
    end
  end

  scenario 'the displayed view count is increased by one upon play', js: true do
    visit tunes_path

    within(:css, '.video-container') do
      within(:css, '.caption-views') do
        expect(page).to have_content('12')
      end

      find(:css, '.play-button').click

      within(:css, '.caption-views') do
        expect(page).to have_content('13')
      end
    end
  end
end
