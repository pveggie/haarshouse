require 'rails_helper'

RSpec.describe "tunes/index", type: :view, sorting: true, viewing: true do

  describe "List Rendering" do
    before do
      assign(:tunes, [
        build_stubbed(:tune, song_title: "Song A"),
        build_stubbed(:tune, song_title: "Song B")
      ])
    end

    it "renders a list of tunes" do
      render
      expect(rendered).to match(/Song A/)
      expect(rendered).to match(/Song B/)
    end

    it "renders play buttons" do
      render
      expect(rendered).to have_css('.play-button', count: 2)
    end
  end

  describe "Tune details display" do
    before { assign(:tunes, [build_stubbed(:tune, views: 6544)]) }

    it "displays the game title" do
      render
      expect(rendered).to match(/Fenris Theme/)
    end

    it "displays the song title" do
      render
      expect(rendered).to match(/Dragon Age 2/)
    end

    it "displays the number of views" do
      render
      expect(rendered).to match(/6544/)
    end
  end
end
