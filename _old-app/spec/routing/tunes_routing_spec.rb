require "rails_helper"

RSpec.describe TunesController, type: :routing do
  describe "routing" do
    it "routes to #index as the homepage", sorting: true, viewing: true do
      expect(get: "/").to route_to("tunes#index")
    end

    it "routes to #index", sorting: true, viewing: true do
      expect(get: "/tunes").to route_to("tunes#index")
    end

    it "routes to #search", viewing: true, searching: true do
      expect(get:"/tunes/search").to route_to("tunes#search")
    end

    it "routes to #show", viewing: true do
      expect(get: "/tunes/1").to route_to("tunes#show", id: "1")
    end

    it "routes to #new", adding: true do
      expect(get: "/tunes/new").to route_to("tunes#new")
    end

    it "routes to #edit", editing: true do
      expect(get: "/tunes/1/edit").to route_to("tunes#edit", id: "1")
    end

    it "routes to #create", adding: true do
      expect(post: "/tunes").to route_to("tunes#create")
    end

    it "routes to #update via PUT", editing: true do
      expect(put: "/tunes/1").to route_to("tunes#update", id: "1")
    end

    it "routes to #update via PATCH", editing: true do
      expect(patch: "/tunes/1").to route_to("tunes#update", id: "1")
    end

    it "routes to #destroy", deleting: true do
      expect(delete: "/tunes/1").to route_to("tunes#destroy", id: "1")
    end
  end
end
