require 'rails_helper'

RSpec.feature 'Delete tunes' do
  before(:all) do
      Tune.delete_all
      FactoryGirl.create(:tune, game_title: "a", song_title: "a", youtube_video_id: "aaaaaaaaaaa")
      FactoryGirl.create(:tune)
  end

  scenario 'user can use delete button to delete song', js: true do
    # go to add tunes form. No videos exist
    visit tunes_path
    expect(page).to have_css('.video-container', count: 2)

    within(:css, '#container-dSCq7jTL7tQ') do
      # find(:xpath, '//span[1]', match: :first).click
      find(:css, '.delete-button').click
    end

    expect(page).to have_css('.video-container', count: 1)
    expect(page).to_not have_css('#container-dSCq7jTL7tQ')
  end
end
