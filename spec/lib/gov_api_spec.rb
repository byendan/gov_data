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

    it "can find data for the rover galary" do
      parsed_json = JSON.parse(File.read("./spec/support/fixtures/rover.json"))
      desired_data = ["img_src"]

      expected_image_count = 25

      returned_data = find_data(parsed_json, desired_data[0])

      expect(returned_data.length).to eq(expected_image_count)
      expect(returned_data.class).to eq(Array)
      expect(returned_data[0].class).to eq(String)
    end
  end
end
