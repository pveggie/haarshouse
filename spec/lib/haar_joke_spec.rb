require 'rails_helper'

require 'json'
require 'open-uri'
require 'haar_joke'
require 'webmock/rspec'

RSpec.describe HaarJoke do
  before do
    stub_request(:get, /api.icndb.com/).
    to_return(status: 200,
              body: '{ "type": "success",
                      "value": { "joke": "Chuck Norris wears Haar pajamas." } }',
              headers: {})
  end

  it "can be used to create HaarJoke objects" do
    expect(HaarJoke.new).to be_a(HaarJoke)
  end

  let(:joke) { HaarJoke.new }

  describe ".text" do
    it "returns a joke about Haar when called" do
      expect(joke.text).to match /Haar/
    end
  end

  describe "Substitutions" do
    it "replaces Chuck Norris with Haar" do
      expect(joke.instance_eval {generate_joke}).to eql("Haar wears Haar pajamas.")
    end

    it "replaces various real world terms with Fire Emblem terms" do
      stub_request(:get, /api.icndb.com/).
      to_return(status: 200,
                body: '{ "type": "success",
                        "value": { "joke": "Chuck Norris america pick-up" } }',
                headers: {})
      expect(joke.text).to eql("Haar Daein wyvern")
    end
  end

  describe "private methods" do
    describe "get_joke_from_api" do
      context "when api is available" do
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

    describe "accept_joke?" do
      it "does not accept jokes from the filters list"do
        expect(joke.instance_eval {accept_joke?("woman")}).to eql(false)
      end
    end
  end
end
