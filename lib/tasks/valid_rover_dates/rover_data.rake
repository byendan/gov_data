namespace :valid_rover_dates do
  desc "Update available options for rover data"
  task rover_data: :environment do

    log = ActiveSupport::Logger.new('log/test_rake.log')
    log.info "This rake task is working"


    rovers = %w(Curiosity Spirit Opportunity)

    rovers.each do |rover|
      rover_manifest = get_manifest(rover)
      max_sol = rover_manifest["photo_manifest"]["max_sol"]
      photos = rover_manifest["photo_manifest"]["photos"]

      # If there is no records for the rover the start sol is 0
      if ValidRoverDate.where("rover = ?", rover).length == 0
        start_sol = 0
      else
      # If there are records for the rover the start sol will be
      # 1 plus the most recent records sol
        start_sol = ValidRoverDate.where("rover = ?", rover).order(:created_at).last.sol
        start_sol += 1
      end

      # reduce size of photos array to only include photos that have not been added
      photos = reduce_photos(photos) if start_sol > 0

      photos.each do |photo|

        # Sets up the query for the rover on this sol without selecting a camera
        basic_valid_date = ValidRoverDate.new()
        basic_valid_date.sol = photo["sol"].to_i
        basic_valid_date.rover = rover
        basic_valid_date.camera = "none"
        basic_valid_date.save
        log.info "This item was just added to the database: #{basic_valid_date}"

        # saves dates for each camera for the rover on this sol
        photo["cameras"].each do |camera|
          camera_valid_date = ValidRoverDate.new()
          camera_valid_date.sol = photo["sol"].to_i
          camera_valid_date.rover = rover
          camera_valid_date.camera = camera
          camera_valid_date.save
          log.info "This item was just added to the database: #{camera_valid_date}"
        end

      end

    end

  end
end

def get_manifest(rover)

  api_key = ENV["GOV_API_KEY"]
  query = "https://api.nasa.gov/mars-photos/api/v1/manifests/#{rover}?api_key=#{api_key}"

  return JSON.parse Net::HTTP.get(URI(query))
end

def reduce_photos(photos)
  for i in 0...photos.length do
    if photos[i]["sol"] >= start_sol
      return photos[i...photos.length]
    end
  end
  return photos
end
