require 'rails_helper'

class AnonymousController < ApplicationController
  before_filter :joke
  # Method that can be called in test to trigger variable assignment
  # and provide a view.
  # This method has a test/dev-only route.
  def show
    render :text => 'Hello'
  end
end

RSpec.describe AnonymousController do
    it "assigns a joke as @joke" do
      get :show , {}
      expect(assigns(:haar_joke)).to match(/Haar/)
    end
end
