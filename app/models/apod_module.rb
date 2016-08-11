class ApodModule < ActiveRecord::Base


  def initialize(options={})
    super
    self.name = "NASA Astronomical Picture of the Day"
    self.base_query = 'https://api.nasa.gov/planetary/apod?'
  end

  def build_query
    return self.base_query
  end

  def return_data(json_response)
    return_hash = Hash.new

    return_hash[:title] = json_response["title"]
    return_hash[:description] = json_response["explanation"]
    return_hash[:img_url] = json_response["hdurl"]

    return_hash
  end

end
