require 'rails_helper'

class AnonymousController < ApplicationController
  # Method that can be called in test to trigger variable assignment
  # and provide a view.
  # This method has a test/dev-only route.
  def show
    render :plain => 'Show called'
  end
end

RSpec.describe AnonymousController do
    it "assigns a joke as @haar_joke" do
      get :show
      expect(assigns(:haar_joke)).to match(/Haar/)
    end
end
