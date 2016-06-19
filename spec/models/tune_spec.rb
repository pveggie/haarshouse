require 'rails_helper'

# Template: https://gist.github.com/kyletcarlson/6234923
RSpec.describe Tune, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.build(:tune)).to be_valid
  end

  describe 'ActiveRecord valiations' do
    let(:test_tune) { FactoryGirl.build(:tune) }

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
      expect(test_tune).to validate_uniqueness_of(:song_title)
                       .scoped_to(:game_title)
                       .with_message("This song has already been added.")
    end

    it 'requires youtube_video_id to be unique' do
      expect(test_tune).to validate_uniqueness_of(:youtube_video_id)
                       .with_message("This video has already been added.")
    end

    ## ==== YOUTUBE LINK FORMATTING
    it 'is valid with a youtube_video_id as a full link' do
      expect(test_tune).to allow_value("https://www.youtube.com/watch?v=dSCq7jTL7tQ")
                       .for(:youtube_video_id)
    end

    it 'is valid with a youtube_video_id as a partial containing the id' do
      expect(test_tune).to allow_value("youtube.com/watch?v=dSCq7jTL7tQ")
                       .for(:youtube_video_id)
    end

    it 'is invalid when the youtube_video_id has the wrong format' do
      expect(test_tune).to_not allow_value("Hi there").for(:youtube_video_id)
    end
  end


  context "callbacks" do
    # http://guides.rubyonrails.org/active_record_callbacks.html
    # https://github.com/beatrichartz/shoulda-callback-matchers/wiki

    let(:test_tune) { FactoryGirl.create(:tune) }

    it 'calls the #extract_video_id_from_youtube_url method before saving' do
      expect(test_tune).to callback(:extract_video_id_from_youtube_url).before(:save)
    end

    it 'correctly saves only video_id part of the youtube_url' do
      test_tune.save
      expect(Tune.last.youtube_video_id).to eq('dSCq7jTL7tQ')
    end

  end

  describe "scopes" do

    before(:all) do
      Tune.delete_all
      song_details = [
        { game_title: "Assassin's Creed",
          song_title: "Ezio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tQ",
          views: 0 },
        { game_title: "Zssassin's Creed",
          song_title: "Azio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tZ",
          views: 5 },
        { game_title: "Mssassin's Creed",
          song_title: "Zzio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7td",
          views: 11 },
        ]

        song_details.each do |song|
          FactoryGirl.create(:tune,
                            game_title: song[:game_title],
                            song_title: song[:song_title],
                            youtube_video_id: song[:youtube_video_id],
                            views: song[:views])
        end
    end

  it '.by_song sorts videos from A-Z by song_title' do
    song_titles = Tune.by_song.pluck(:song_title)
    expect(song_titles).to eq(song_titles.sort)
  end

  it '.by_game sorts videos from A-Z by game_title' do
    game_titles = Tune.by_game.pluck(:game_title)
    expect(game_titles).to eq(game_titles.sort)
  end

  it '.most_viewed sorts videos to show the most viewed first' do
    views = Tune.most_viewed.pluck(:views)
    expect(views).to eq(views.sort)
  end
  #   # It's a good idea to create specs that test a failing result for each scope, but that's up to you
  #   it ".loved returns all votes with a score > 0" do
  #     product = create(:product)
  #     love_vote = create(:vote, score: 1, product_id: product.id)
  #     expect(Vote.loved.first).to eq(love_vote)
  #   end

  #   it "has another scope that works" do
  #     expect(model.scope_name(conditions)).to eq(result_expected)
  #   end
  end

  # describe "public instance methods" do
  #   context "responds to its methods" do
  #     it { expect(factory_instance).to respond_to(:public_method_name) }
  #     it { expect(factory_instance).to respond_to(:public_method_name) }
  #   end

  #   context "executes methods correctly" do
  #     context "#method name" do
  #       it "does what it's supposed to..."
  #         expect(factory_instance.method_to_test).to eq(value_you_expect)
  #       end

  #       it "does what it's supposed to..."
  #         expect(factory_instance.method_to_test).to eq(value_you_expect)
  #       end
  #     end
  #   end
  # end

  # describe "public class methods" do
  #   context "responds to its methods" do
  #     it { expect(factory_instance).to respond_to(:public_method_name) }
  #     it { expect(factory_instance).to respond_to(:public_method_name) }
  #   end

  #   context "executes methods correctly" do
  #     context "self.method name" do
  #       it "does what it's supposed to..."
  #         expect(factory_instance.method_to_test).to eq(value_you_expect)
  #       end
  #     end
  #   end
  # end

end
