require 'spec_helper'
require 'gov_api'
include GovApi

RSpec.describe GovApi do

  describe "get desired data from endpoint" do

    it "responds with desired NASA APOD data" do
      parsed_json = JSON.parse(File.read("./spec/support/fixtures/apod.json"))[0]
      desired_data_keys = ['date', 'hdurl', 'title']

      expected_api_hash = { "date" => "2016-07-14",
                            "hdurl" => "http://apod.nasa.gov/apod/image/1607/NGC1309Jeff_full.jpg",
                            "title" => "NGC 1309: Spiral Galaxy and Friends" }

      api_result_hash = get_data(parsed_json, desired_data_keys)

      expect(api_result_hash).to eq(expected_api_hash)

    end
  end
end
