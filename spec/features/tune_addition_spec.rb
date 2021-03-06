require 'rails_helper'

RSpec.feature 'Tune addition', adding: true, visible: true do
  given(:valid_data) { attributes_for(:tune) }
  given(:invalid_data) { attributes_for(:tune, song_title: nil) }
  background { resize_window_default }

  scenario 'Adding a song with invalid user input' do
    # go to add tunes form. No videos exist
    visit tunes_path
    expect(page).to_not have_css('.video-container')
    within '.toolbar-full' do
      click_link('Add Song')
    end

    # fill in form and submit
    check_page_and_add_tune(invalid_data)

    # fail and stay on add tune form
    expect(page).to have_field('Game title')
    expect(page).to have_content(/can't be blank/)

    # go back to index. no tune has been added
    visit tunes_path
    expect(page).to_not have_css('.video-container')
  end

  scenario 'Adding first song with valid user input' do
    # go to add tunes form
    visit tunes_path
    within '.toolbar-full' do
      click_link('Add Song')
    end

    # fill in form and submit
    check_page_and_add_tune(valid_data)

    # redirect to tunes index. song with correct id has been added
    expect(page).to have_css('.video-container')
    expect(page).to have_css('#dSCq7jTL7tQ')
  end

  background(run: true) do
    create(
      :tune, game_title: "a", song_title: "a", youtube_video_id: "aaaaaaaaaaa"
    )
    create(
      :tune, game_title: "b", song_title: "b", youtube_video_id: "aaaaaaaaaab"
    )
    create(
      :tune, game_title: "c", song_title: "c", youtube_video_id: "aaaaaaaaaac"
    )
  end

  scenario 'Adding a song when some exist already', run: true do
    # go to add tunes form.
    visit tunes_path
    expect(page).to have_css('.video-container', count: 3)
    within '.toolbar-full' do
      click_link('Add Song')
    end

    # fill in form and submit
    check_page_and_add_tune(valid_data)

    # redirect to tunes index. song with correct id has been added
    expect(page).to have_css('.video-container', count: 4)
    expect(page).to have_css('#dSCq7jTL7tQ')
  end

  scenario 'Cancelling adding a song' do
    visit tunes_path
    expect(page).to_not have_css('.video-container')

    within '.toolbar-full' do
      click_link('Add Song')
    end
    click_link('Cancel')
    expect(page).to_not have_field('Game title')
    expect(page).to_not have_css('.video-container')
  end

  def check_page_and_add_tune(data)
    expect(page).to have_field('Game title')
    fill_in 'Game title', with: data[:game_title]
    fill_in 'Song title', with: data[:song_title]
    fill_in 'Youtube video', with: data[:youtube_video_id]
    click_button 'Create Tune'
  end
end
