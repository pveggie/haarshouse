require 'rails_helper'

# Template: https://gist.github.com/kyletcarlson/6234923
RSpec.describe Tune, type: :model do
  # Factory
  it "has a valid factory" do
    expect(build(:tune)).to be_valid
  end

  describe 'ActiveRecord valiations', adding: true, editing: true do
    let(:test_tune) { build(:tune) }

    # it { expect(test_tune).to validate_presence_of(:game_title)}
    # template uses short hand but I'm writing everything out in full
    # for learning purposes.
    it 'is invalid with no game_title' do
      expect(test_tune).to validate_presence_of(:game_title)
    end

    it 'is invalid with no song_title' do
      expect(test_tune).to validate_presence_of(:song_title)
    end

    it 'is invalid with no youtube_video_id' do
      expect(test_tune).to validate_presence_of(:youtube_video_id)
    end

    it 'requires song_title, game_title pairs to be unique' do
      expect(test_tune)
        .to validate_uniqueness_of(:song_title)
        .scoped_to(:game_title)
        .with_message("This song has already been added.")
    end

    it 'requires youtube_video_id to be unique' do
      expect(test_tune)
        .to validate_uniqueness_of(:youtube_video_id)
        .with_message("This video has already been added.")
    end

    ## ==== YOUTUBE LINK FORMATTING
    it 'is valid with a youtube_video_id as a full link' do
      expect(test_tune)
        .to allow_value("https://www.youtube.com/watch?v=dSCq7jTL7tQ")
        .for(:youtube_video_id)
    end

    it 'is valid with a youtube_video_id as a partial containing the id' do
      expect(test_tune)
        .to allow_value("youtube.com/watch?v=dSCq7jTL7tQ")
        .for(:youtube_video_id)
    end

    it 'is valid with a youtube_video_id containing only the id' do
      expect(test_tune)
        .to allow_value("dSCq7jTL7tZ")
        .for(:youtube_video_id)
    end

    it 'is invalid when the youtube_video_id has the wrong format' do
      expect(test_tune).to_not allow_value("Hi there").for(:youtube_video_id)
    end
  end

  describe "Callbacks", adding: true, editing: true do
    # http://guides.rubyonrails.org/active_record_callbacks.html
    # https://github.com/beatrichartz/shoulda-callback-matchers/wiki
    let(:test_tune) { create(:tune) }

    it 'calls the #extract_video_id_from_youtube_url method before saving' do
      expect(test_tune)
        .to callback(:extract_video_id_from_youtube_url).before(:save)
    end

    it 'correctly saves only video_id part of the youtube_url' do
      test_tune.save
      expect(Tune.last.youtube_video_id).to eq('dSCq7jTL7tQ')
    end
  end

  describe "Scopes", viewing: true, sorting: true do
    after(:all) { Tune.destroy_all }

    before(:all) do
      song_details = [
        { game_title: "Assassin's Creed",
          song_title: "ezio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tQ",
          views: 0 },
        { game_title: "Zssassin's Creed",
          song_title: "Azio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tZ",
          views: 5 },
        { game_title: "mssassin's Creed",
          song_title: "Zzio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7td",
          views: 11 }
      ]

      song_details.each do |song|
        create(
          :tune,
          game_title: song[:game_title],
          song_title: song[:song_title],
          youtube_video_id: song[:youtube_video_id],
          views: song[:views]
        )
      end
    end

    it '.by_date sorts videos by most recently added' do
      song_titles = Tune.by_date.pluck(:song_title)
      expect(song_titles)
        .to eq(["Zzio's Family", "Azio's Family", "ezio's Family"])
    end

    it '.by_song sorts videos from A-Z by song_title' do
      song_titles = Tune.by_song.pluck(:song_title)
      expect(song_titles)
        .to eq(song_titles.sort { |a, b| a.downcase <=> b.downcase })
    end

    it '.by_game sorts videos from A-Z by game_title' do
      game_titles = Tune.by_game.pluck(:game_title)
      expect(game_titles)
        .to eq(game_titles.sort { |a, b| a.downcase <=> b.downcase })
    end

    it '.most_viewed sorts videos to show the most viewed first (descending)' do
      views = Tune.most_viewed.pluck(:views)
      expect(views)
        .to eq(views.sort { |a, b| b <=> a })
    end
  end

  describe "Searching", searching: true, viewing: true do
    after(:all) { Tune.destroy_all }

    before(:all) do
      song_details = [
        { game_title: "Assassin's Creed",
          song_title: "Something Dragon",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tQ",
          views: 0 },
        { game_title: "Dragon Age 2",
          song_title: "Fenris Theme",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tZ",
          views: 5 },
        { game_title: "firedragonfire",
          song_title: "Something Something",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7td",
          views: 11 }
      ]

      song_details.each do |song|
        create(
          :tune,
          game_title: song[:game_title],
          song_title: song[:song_title],
          youtube_video_id: song[:youtube_video_id],
          views: song[:views]
        )
      end
    end

    it '.search returns correct result for a perfect match' do
      results = Tune.search("Fenris Theme").pluck(:song_title)
      expect(results).to eq(["Fenris Theme"])
    end

    it '.search returns correct result for a partial match' do
      results = Tune.search("Age").pluck(:game_title)
      expect(results).to eq(["Dragon Age 2"])
    end

    it '.search is case insensitive' do
      results = Tune.search("fenris").pluck(:song_title)
      expect(results).to eq(["Fenris Theme"])
    end

    it '.search returns matches for both game_title and song_title' do
      results = Tune.search("dragon").pluck(:song_title)
      expect(results).to eq(["Something Dragon", "Fenris Theme"])
    end

    it '.search finds matches when \'s is not typed' do
      results = Tune.search("assassin").pluck(:game_title)
      expect(results).to eq(["Assassin's Creed"])
    end

    it '.search finds matches containing the typed word' do
      results = Tune.search("ass").pluck(:game_title)
      expect(results).to eq(["Assassin's Creed"])
    end

    # need to add fuzzy matchers or dmetaphone
    # it '.search recognises numbers as words and numerals' do
    #   results = Tune.search("Dragon Age Two").pluck(:game_title)
    #   expect(results).to eq(["Dragon Age 2"])
    # end
  end
end
