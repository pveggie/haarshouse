require 'rails_helper'

RSpec.feature 'Tune search', viewing: true, searching: true do

  scenario "user searches a term and sees a list of matching videos" do
    visit_tunes_path


  end
