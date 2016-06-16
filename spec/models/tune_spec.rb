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
      expect(test_tune).to allow_value("dSCq7jTL7tQ")
                       .for(:youtube_video_id)
    end

    it 'is invalid when the youtube_video_id has the wrong format' do
      expect(test_tune).to_not allow_value("Hi there").for(:youtube_video_id)
    end
  end

  # describe "ActiveRecord associations" do
  #   # http://guides.rubyonrails.org/association_basics.html
  #   # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/frames
  #   # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveRecord

  #   # Performance tip: stub out as many on create methods as you can when you're testing validations
  #   # since the test suite will slow down due to having to run them all for each validation check.
  #   #
  #   # For example, assume a User has three methods that fire after one is created, stub them like this:
  #   #
  #   # before(:each) do
  #   #   User.any_instance.stub(:send_welcome_email)
  #   #   User.any_instance.stub(:track_new_user_signup)
  #   #   User.any_instance.stub(:method_that_takes_ten_seconds_to_complete)
  #   # end
  #   #
  #   # If you performed 5-10 validation checks against a User, that would save a ton of time.

  #   # Associations
  #   it { expect(profile).to belong_to(:user) }
  #   it { expect(wishlist_item).to belong_to(:wishlist).counter_cache }
  #   it { expect(metric).to belong_to(:analytics_dashboard).touch }
  #   it { expect(user).to have_one(:profile }
  #   it { expect(classroom).to have_many(:students) }
  #   it { expect(initech_corporation).to have_many(:employees).with_foreign_key(:worker_drone_id) }
  #   it { expect(article).to have_many(:comments).order(:created_at) }
  #   it { expect(user).to have_many(:wishlist_items).through(:wishlist) }
  #   it { expect(todo_list).to have_many(:todos).dependent(:destroy) }
  #   it { expect(account).to have_many(:billings).dependent(:nullify) }
  #   it { expect(product).to have_and_belong_to_many(:descriptors) }
  #   it { expect(gallery).to accept_nested_attributes_for(:paintings) }

  #   # Read-only matcher
  #   # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveRecord/HaveReadonlyAttributeMatcher
  #   it { expect(asset).to have_readonly_attribute(:uuid) }

  #   # Databse columns/indexes
  #   # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveRecord/HaveDbColumnMatcher
  #   it { expect(user).to have_db_column(:political_stance).of_type(:string).with_options(default: 'undecided', null: false)
  #   # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveRecord:have_db_index
  #   it { expect(user).to have_db_index(:email).unique(:true)
  # end

  # context "callbacks" do
  #   # http://guides.rubyonrails.org/active_record_callbacks.html
  #   # https://github.com/beatrichartz/shoulda-callback-matchers/wiki

  #   let(:user) { create(:user) }

  #   it { expect(user).to callback(:send_welcome_email).after(:create) }
  #   it { expect(user).to callback(:track_new_user_signup).after(:create) }
  #   it { expect(user).to callback(:make_email_validation_ready!).before(:validation).on(:create) }
  #   it { expect(user).to callback(:calculate_some_metrics).after(:save) }
  #   it { expect(user).to callback(:update_user_count).before(:destroy) }
  #   it { expect(user).to callback(:send_goodbye_email).before(:destroy) }
  # end

  # describe "scopes" do
  #   # It's a good idea to create specs that test a failing result for each scope, but that's up to you
  #   it ".loved returns all votes with a score > 0" do
  #     product = create(:product)
  #     love_vote = create(:vote, score: 1, product_id: product.id)
  #     expect(Vote.loved.first).to eq(love_vote)
  #   end

  #   it "has another scope that works" do
  #     expect(model.scope_name(conditions)).to eq(result_expected)
  #   end
  # end

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
