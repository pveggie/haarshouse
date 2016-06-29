require 'rails_helper'

feature 'User adds tune' do

  before(:all) { Tune.delete_all }

  context "with invalid user input" do
    scenario 'Adding a song with invalid user input' do
      # go to add tunes form. No videos exist
      visit tunes_path
      expect(page).to_not have_css('.video-container')
      click_link('Add Song')

      # fill in form and submit
      expect(page).to have_field('Game title')
      fill_in 'Game title', :with => "Dragon Age 2"
      fill_in 'Song title', :with => "Fenris Theme"
      fill_in 'Youtube video', :with => "blah"
      click_button 'Create Tune'

      # fail and stay on add tune form
      expect(page).to have_field('Game title')
      # -- TO DO - add flash messages
      # within("div.flash") do
      #   expect(page).to have_content("Song not created.")
      # end

      # go back to index. no tune has been added
      visit tunes_path
      expect(page).to_not have_css('.video-container')
    end
  end

  context "With valid user input" do
    scenario 'Adding first song' do
      # go to add tunes form
      visit tunes_path
      click_link('Add Song')

      # fill in form and submit
      check_page_and_add_tune

      # redirect to tunes index. song with correct id has been added
      expect(page).to have_css('.video-container')
      expect(page).to have_css('#dSCq7jTL7tQ')
    end

    # -- Songs for adding song when some already exist
    before do
      FactoryGirl.create(:tune, game_title: "a", song_title: "a", youtube_video_id: "aaaaaaaaaaa")
      FactoryGirl.create(:tune, game_title: "b", song_title: "b", youtube_video_id: "aaaaaaaaaab")
      FactoryGirl.create(:tune, game_title: "c", song_title: "c", youtube_video_id: "aaaaaaaaaac")
    end

    scenario 'Adding a song when some exist already' do
      # go to add tunes form. No videos exist
      visit tunes_path
      expect(page).to have_css('.video-container', count: 3)
      click_link('Add Song')

      # fill in form and submit
      check_page_and_add_tune

     # redirect to tunes index. song with correct id has been added
      expect(page).to have_css('.video-container', count: 4)
      expect(page).to have_css('#dSCq7jTL7tQ')
    end
  end

  def check_page_and_add_tune
    expect(page).to have_field('Game title')
    fill_in 'Game title', :with => "Dragon Age 2"
    fill_in 'Song title', :with => "Fenris Theme"
    fill_in 'Youtube video', :with => "youtube.com/watch?v=dSCq7jTL7tQ"
    click_button 'Create Tune'
  end
end
