require 'rails_helper'

RSpec.feature 'Tune deletion', deleting: true, js: true do
  background do
    create(
      :tune, game_title: 'a', song_title: 'a', youtube_video_id: 'aaaaaaaaaaa'
    )
    create(:tune)
  end

  scenario 'user can use delete button to delete song', js: true do
    visit tunes_path
    expect(page).to have_css('.video-container', count: 2)

    within(:css, '#container-dSCq7jTL7tQ') do
      accept_confirm do
        find('.delete-button').click
      end
    end

    expect(page).to have_css('.video-container', count: 1)
    expect(page).to_not have_css('#container-dSCq7jTL7tQ')
  end

  scenario 'song is not deleted if user does not confirm', js: true do
    visit tunes_path
    expect(page).to have_css('.video-container', count: 2)

    within(:css, '#container-dSCq7jTL7tQ') do
      dismiss_confirm do
        find('.delete-button').click
      end
    end

    expect(page).to have_css('.video-container', count: 2)
    expect(page).to have_css('#container-dSCq7jTL7tQ')
  end
end
