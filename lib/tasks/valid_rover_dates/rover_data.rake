namespace :valid_rover_dates do
  desc "Update available options for rover data"
  task rover_data: :environment do

    log = ActiveSupport::Logger.new('log/test_rake.log')
    log.info "This rake task is working"


    rovers = %w(Curiosity Spirit Opportunity)


    if ValidRoverDate.all.length == 0
      rover_data = new_hash
    else
      rover_data = load_valid_dates(rovers)
    end

    rovers.each do |rover|
      rover_manifest = get_manifest(rover)
      max_sol = rover_manifest["photo_manifest"]["max_sol"]
      photos = rover_manifest["photo_manifest"]["photos"]

      # If there are no records for the rover the start sol is 0
      if ValidRoverDate.where("rover = ?", rover).length == 0
        start_sol = 0
      else
      # If there are records for the rover the start sol will be
      # 1 plus the largest sol found from all of the rovers cameras
        check_rovers = ValidRoverDate.where("rover = ?", rover)
        max_sol = 0

        check_rovers.each do |check_rover|
          last_sol = check_rover.sols.split(",").last
          max_sol = last_sol if last_sol > max_sol
        end

        start_sol = max_sol + 1
      end

      # reduce size of photos array to only include photos that have not been added
      photos = reduce_photos(photos) if start_sol > 0

      photos.each do |photo|
        sol = photo["sol"]
        # Loads the sol into the hash for the rover having no specified camera
        rover_data["#{rover}-none"] << sol
        log.info "The sol #{sol} was added to #{rover}-none"

        # Loads the sol for each camera for the rover with pictures on this sol
        photo["cameras"].each do |camera|
          camera = camera.downcase
          log.info "Trying to add data for #{rover} #{camera}"
          rover_data["#{rover}-#{camera}"] << sol
          log.info "The sol #{sol} was added to #{rover}-#{camera}"
        end

      end

    end

    # Uses the data from the hash to make new valid rover date objects
    rover_data.each do |rover_and_cam, sol_text|
      rover, cam = rover_and_cam.split("-")
      if ValidRoverDate.where("rover = ? AND camera = ?", rover, cam).length == 0
        new_valid_dates = ValidRoverDate.new()
        new_valid_dates.rover = rover
        new_valid_dates.camera = cam
        new_valid_dates.sols = sol_text.join(",")
        new_valid_dates.save
      else
        update_valid_dates = ValidRoverDate.where("rover = ? AND camera = ?", rover, cam)
        update_valid_dates.sols = sol_text.join(",")
        update_valid_dates.save
      end
      log.info "#{rover} #{cam} has had it's sols saved"
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

def new_hash
  return_hash = Hash.new()

  return_hash['Curiosity-none'] = Array.new
  return_hash['Curiosity-entry'] = Array.new
  return_hash['Curiosity-fhaz'] = Array.new
  return_hash['Curiosity-rhaz'] = Array.new
  return_hash['Curiosity-mast'] = Array.new
  return_hash['Curiosity-chemcam'] = Array.new
  return_hash['Curiosity-mahli'] = Array.new
  return_hash['Curiosity-mardi'] = Array.new
  return_hash['Curiosity-navcam'] = Array.new
  return_hash['Opportunity-none'] = Array.new
  return_hash['Opportunity-entry'] = Array.new
  return_hash['Opportunity-fhaz'] = Array.new
  return_hash['Opportunity-rhaz'] = Array.new
  return_hash['Opportunity-navcam'] = Array.new
  return_hash['Opportunity-pancam'] = Array.new
  return_hash['Opportunity-minites'] = Array.new
  return_hash['Spirit-none'] = Array.new
  return_hash['Spirit-entry'] = Array.new
  return_hash['Spirit-fhaz'] = Array.new
  return_hash['Spirit-rhaz'] = Array.new
  return_hash['Spirit-navcam'] = Array.new
  return_hash['Spirit-pancam'] = Array.new
  return_hash['Spirit-minites'] = Array.new

  return_hash
end

def load_valid_dates(rovers)
  return_hash = Hash.new

  rovers.each do |rover|
    rovers_with_cams = ValidRoverDate.where("rover = ?", rover)

    rovers_with_cams.each do |r_with_c|
      return_hash["#{rover}-#{r_with_c.camera}"] = r_with_c.sols.split(",")
    end

  end

  return_hash
end
