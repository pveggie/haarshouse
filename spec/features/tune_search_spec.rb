require 'rails_helper'

RSpec.feature 'Tune search', viewing: true, searching: true do

  background do
    create(:tune)
    create(:tune, song_title: "Isabela Theme", youtube_video_id: "eSCq7jTL7tQ")
    create(:tune, song_title: "fenris Thing", youtube_video_id: "fSCq7jTL7tQ")
  end

  scenario "user searches a term and sees a list of matching videos" do
    visit tunes_path

    within('.form-search') do
      fill_in 'q', with: 'fenris'
      click_on "btn-search-submit"
    end

    expect(page).to have_text("Fenris Theme")
    expect(page).to have_text("fenris Thing")
    expect(page).to_not have_text("Isabela Theme")
  end

  scenario "user sees all songs again after clicking filter" do
    visit tunes_path

    within('.form-search') do
      fill_in 'q', with: 'fenris'
      click_on "btn-search-submit"
    end

    expect(page).to_not have_text("Isabela Theme")

    click_on "By Song"

    expect(page).to have_text("Isabela Theme")
  end
end
