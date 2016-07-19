require 'rails_helper'

require 'json'
require 'open-uri'
require 'haar_joke'

RSpec.describe HaarJoke do

  it "can be used to create HaarJoke objects" do
    expect(HaarJoke.new).to be_a(HaarJoke)
  end

  let(:joke) { HaarJoke.new }

  describe ".text" do
    it "returns a joke about Haar when called" do
      expect(joke.text).to match /Haar/
    end
  end

  describe "get_joke_from_api" do
    context "when api is available" do
      it "returns only a string" do
        expect(joke.instance_eval { get_joke_from_api }).to be_a(String)
      end

      it "returns a joke containing the word Haar" do
        expect(joke.instance_eval { get_joke_from_api }).to eq("Chuck Norris wears Haar pajamas.")
      end
    end

    context "when api is not available" do
      it "returns the default string" do
        stub_request(:get, /api.icndb.com/).
        to_return(status: 404,
                body: '{}',
                headers: {})
        expect(joke.instance_eval { get_joke_from_api }).to eq(nil)
      end
    end
  end

  describe "Joke filtering" do
    it "something "do
      allow(joke).to receive(:get_joke_from_api).and_return("Woman Chuck Norris")
      # joke.text
      expect(joke.instance_eval { generate_joke }).to not_return("Woman Haar")
      # expect(joke.text).to eq("Safe Haar")
    end
  end
end
