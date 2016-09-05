require 'rails_helper'

RSpec.feature 'Sort tunes in index' do

  before(:all) do
      Tune.delete_all
      FactoryGirl.create(:tune)
      FactoryGirl.create(:tune, game_title: "gamea", song_title: "songb", youtube_video_id: "aaaaaaaaaaa", views: 0)
      FactoryGirl.create(:tune, game_title: "gameb", song_title: "songa", youtube_video_id: "aaaaaaaaaab", views: 5)
      FactoryGirl.create(:tune, game_title: "gamec", song_title: "songc", youtube_video_id: "aaaaaaaaaac", views:100)
  end

  it "sorts songs by game_title" do
    open_and_check_index
    click_button('By Game')
    # save_and_open_page
    within(:css, '.caption', match: :first) do
      expect(page).to have_content('gamea')
    end
  end

  def open_and_check_index
    visit tunes_path
    within(:css, '.caption', match: :first) do
      expect(page).to have_content('Dragon Age')
    end
  end
end
