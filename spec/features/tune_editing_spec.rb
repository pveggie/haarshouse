require 'rails_helper'

RSpec.feature 'Tune editing', editing: true do
  background do
    create(
      :tune, game_title: "a", song_title: "a", youtube_video_id: "aaaaaaaaaaa"
    )
    create(
      :tune, game_title: "b", song_title: "b", youtube_video_id: "aaaaaaaaaab"
    )
    create(
      :tune, game_title: "c", song_title: "c", youtube_video_id: "aaaaaaaaaac"
    )
    create(:tune)
  end

  scenario 'Editing a song with invalid user input', js: true do
    # go to add tunes form. No videos exist
    visit tunes_path
    expect(page).to have_css('.video-container', count: 4)

    select_song_to_edit
    check_page_and_update_song_title("")

    # fail and stay on add tune form
    expect(page).to have_field('Game title')
    expect(page).to have_content(/can't be blank/)

    # go back to index. tune not updated
    visit tunes_path
    within(:css, '#container-dSCq7jTL7tQ') do
      expect(page).to have_content('Dragon Age 2 - Fenris Theme')
    end
  end

  scenario 'Editing a song with valid user input', js: true do
    # go to add tunes form. No videos exist
    visit tunes_path
    expect(page).to have_css('.video-container', count: 4)
    # save_and_open_page

    select_song_to_edit
    check_page_and_update_song_title("Dragon Age II")

    # redirected to index, tune updated
    expect(page).to have_css('.video-container')
    within(:css, '#container-dSCq7jTL7tQ') do
      expect(page).to have_content('Dragon Age II - Fenris Theme')
    end
  end

  def select_song_to_edit
    within(:css, '#container-dSCq7jTL7tQ') do
      # find(:xpath, '//span[1]', match: :first).click
      find(:css, '.edit-button').click
    end
  end

  def check_page_and_update_song_title(new_title)
    expect(page).to have_field('Game title')
    fill_in 'Game title', with: new_title
    click_button 'Update Tune'
  end
end
