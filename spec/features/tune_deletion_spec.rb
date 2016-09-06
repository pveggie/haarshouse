require 'rails_helper'

RSpec.feature 'Tune deletion' do
  background do
      create(:tune, game_title: "a", song_title: "a", youtube_video_id: "aaaaaaaaaaa")
      create(:tune)
  end

  scenario 'user can use delete button to delete song', js: true do
    # go to add tunes form. No videos exist
    visit tunes_path
    expect(page).to have_css('.video-container', count: 2)

    within(:css, '#container-dSCq7jTL7tQ') do
      find(:css, '.delete-button').click
    end

    expect(page).to have_css('.video-container', count: 1)
    expect(page).to_not have_css('#container-dSCq7jTL7tQ')
  end
end
