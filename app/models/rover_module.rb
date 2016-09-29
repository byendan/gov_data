class RoverModule < ActiveRecord::Base
  validates :rover, presence: true
  validates :date, presence: true

  def initialize(options={})
    super
    self.name = "Rover Pictures"
    self.base_query = 'https://api.nasa.gov/mars-photos/api/v1/rovers/'
  end

  def rover_types
    ['curiosity', 'opportunity', 'spirit']
  end

  def camera_types
    {
      'Curiosity' => ['fhaz', 'rhaz', 'mast', 'chemcam', 'mahli', 'mardi', 'navcam'],
      'Opportunity and Spirit' => ['fhaz', 'rhaz', 'navcam', 'pancam', 'minites']
    }
  end

  def build_query
    return_query = self.base_query
    return_query += "#{self.rover}/photos?"
    return_query += "earth_date=#{self.date}&"
    return_query += "camera=#{self.camera}&" if self.camera != nil

    return_query
  end

  def build_query_with_page(page)
    query = build_query
    query += "page=#{page}&"
    return query
  end

  def return_array(json_response)
    pictures = []

    if json_response["photos"] == nil
      return "no data found"
    else

      json_response["photos"].each do |picture_hash|
        pictures << picture_hash["img_src"]
      end
    end


    return pictures
  end
end
