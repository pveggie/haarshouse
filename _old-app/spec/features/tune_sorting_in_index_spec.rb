require 'rails_helper'

RSpec.feature 'Tune sorting in index', viewing: true, sorting: true do
  # Not going to change any of the data for these tests.
  after(:all) { Tune.destroy_all }

  background(:all) do
    create(
      :tune,
      game_title: 'gamea', song_title: 'songb',
      youtube_video_id: 'aaaaaaaaaaa', views: 0
    )
    create(
      :tune,
      game_title: 'gameb', song_title: 'songa',
      youtube_video_id: 'aaaaaaaaaab', views: 5
    )
    create(
      :tune,
      game_title: 'gamec', song_title: 'songc',
      youtube_video_id: 'aaaaaaaaaac', views: 100
    )
    create(
      :tune,
      game_title: 'Zzzzz', song_title: 'Zzzzz',
      views: 1
    )
  end

  scenario 'user sees songs by last added if no sort is chosen' do
    visit tunes_path
    within(:css, '.caption', match: :first) do
      expect(page).to have_content('Zzzzz')
    end
  end

  scenario 'user can sort songs by game title' do
    visit tunes_path
    click_button('By Game')
    within(:css, '.caption', match: :first) do
      expect(page).to have_content('songb')
      expect(page).to_not have_content('Zzzzz')
    end
  end

  scenario 'user can sort songs by song title' do
    visit tunes_path
    click_button('By Song')
    within(:css, '.caption', match: :first) do
      expect(page).to have_content('songa')
      expect(page).to_not have_content('Zzzzz')
    end
  end

  scenario 'user can sort songs by most viewed' do
    visit tunes_path
    click_button('Most Viewed')
    within(:css, '.caption', match: :first) do
      expect(page).to have_content('songc')
      expect(page).to_not have_content('Zzzzz')
    end
  end
end
