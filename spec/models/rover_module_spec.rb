require 'rails_helper'

RSpec.describe RoverModule, type: :model do
  describe "basic functionality for the rover module" do

    it "initializes the module successfully" do
      test_module = RoverModule.new()

      expect(test_module.name).to eq("Rover Pictures")
      expect(test_module.base_query).to eq('https://api.nasa.gov/mars-photos/api/v1/rovers/')
    end

    it "validates rover and date" do
      test_module = RoverModule.new(rover: "curiosity", date:"2015-6-3")

      expect(test_module).to be_valid
    end

    it "builds a query successfully" do
      test_module = RoverModule.new(rover: "curiosity", date: "2015-6-3")
      test_module.save

      expected_query = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&'

      expect(test_module.build_query).to eq(expected_query)
    end

    it "finds the pictures from the json response" do
      test_module = RoverModule.new(rover: "curiosity", date: "2015-6-3")
      test_module.save
      json_data = JSON.parse(File.read("./spec/support/fixtures/rover.json"))

      expected_image_count = 25
  
      returned_data = test_module.return_array(json_data)

      expect(returned_data.length).to eq(expected_image_count)
      expect(returned_data.class).to eq(Array)
      expect(returned_data[0].class).to eq(String)
    end
  end
end
