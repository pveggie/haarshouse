require 'rails_helper'

RSpec.describe "tunes/new", type: :view do
  before do
    assign(:tune, Tune.new)
  end

  let(:tune) { FactoryGirl.build_stubbed(:tune) }

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
      assert_select "input#tune_youtube_video_id[name=?]", "tune[youtube_video_id]"
    end

  end
end


# describe "todo_lists/new" do
#   before(:each) do
#     assign(:todo_list, stub_model(TodoList,
#       :title => "MyString",
#       :description => "MyText"
#     ).as_new_record)
#   end

#   it "renders new todo_list form" do
#     render

#     # Run the generator again with the --webrat flag if you want to use webrat matchers
#     assert_select "form[action=?][method=?]", todo_lists_path, "post" do
#       assert_select "input#todo_list_title[name=?]", "todo_list[title]"
#       assert_select "textarea#todo_list_description[name=?]", "todo_list[description]"
#     end
#   end
# end
