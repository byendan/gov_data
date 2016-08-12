require 'rails_helper'

RSpec.describe ApodModule, type: :model do
  describe "basic functionality for the apod module" do

    it "initializes the module correctly" do
      test_module = ApodModule.new

      expect(test_module.name).to eq("NASA Astronomical Picture of the Day")
      expect(test_module.base_query).to eq('https://api.nasa.gov/planetary/apod?')
    end

    it "retrieves the correct query" do
      test_module = ApodModule.new
      test_module.save

      expect(test_module.build_query).to eq('https://api.nasa.gov/planetary/apod?')
    end

    it "builds the return data properly" do
      test_module = ApodModule.new
      test_module.save
      json_data = JSON.parse(File.read("./spec/support/fixtures/apod.json"))[0]

      expected_api_hash = {
                            img_url: "http://apod.nasa.gov/apod/image/1607/NGC1309Jeff_full.jpg",
                            title: "NGC 1309: Spiral Galaxy and Friends",
                            description: "A gorgeous spiral galaxy some 100 million light-years distant, NGC 1309 lies on the banks of the constellation of the River (Eridanus). NGC 1309 spans about 30,000 light-years, making it about one third the size of our larger Milky Way galaxy. Bluish clusters of young stars and dust lanes are seen to trace out NGC 1309's spiral arms as they wind around an older yellowish star population at its core. Not just another pretty face-on spiral galaxy, observations of NGC 1309's recent supernova and Cepheid variable stars contribute to the calibration of the expansion of the Universe. Still, after you get over this beautiful galaxy's grand design, check out the array of more distant background galaxies also recorded in this sharp, reprocessed,  Hubble Space Telescope view."
                          }

      module_data = test_module.return_data(json_data)

      expect(module_data).to eq(expected_api_hash)
    end
  end
end
