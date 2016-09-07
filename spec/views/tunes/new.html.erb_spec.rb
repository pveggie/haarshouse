require 'rails_helper'

RSpec.describe "tunes/new", type: :view, adding: true do
  let(:tune) { build_stubbed(:tune) }

  before { assign(:tune, Tune.new) }

  it "renders new tune form" do
    render
    assert_select "form[action=?][method=?]", tunes_path, "post"
  end

  describe "form fields" do
    before { render }

    it "has an input field for game_title" do
      assert_select "input#tune_game_title[name=?]", "tune[game_title]"
    end

    it "has an input field for song_title" do
      assert_select "input#tune_song_title[name=?]", "tune[song_title]"
    end

    it "has an input field for youtube_video_id" do
      assert_select "input#tune_youtube_video_id[name=?]",
                    "tune[youtube_video_id]"
    end
  end
end
