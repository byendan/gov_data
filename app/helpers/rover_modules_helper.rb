module RoverModulesHelper
  include GovApi

  def has_more_pictures(picture_count)
    picture_count >= 25
  end

  def get_manifest(rover)
    rover_manifest_query = "https://api.nasa.gov/mars-photos/api/v1/manifests/#{rover}?"
    make_request(rover_manifest_query)
  end

  # Logs manifests to the fixture directory as json for testing
  def log_mainfests
    rover_names.each do |rover|
      sample_manifest = get_manifest(rover)

      File.open("test/fixtures/#{rover}_sample_manifest.json","w") do |f|
        f.write(sample_manifest)
      end

    end
  end

  def populate_valid_dates
    rover_camera_sols = {}

    rover_names.each do |rover|
      rover_manifest = get_manifest(rover)
      photos = rover_manifest["photo_manifest"]["photos"]

      photos.each do |photo|
        sol = photo["sol"]
        rover_camera_sols = push_or_new_array(rover_camera_sols, "#{rover}-none", sol)

        photo["cameras"].each do |camera|
          camera = camera.downcase
          rover_camera_sols = push_or_new_array(rover_camera_sols, "#{rover}-#{camera}", sol)
        end
      end
    end

    make_valid_date_objects(rover_camera_sols)
  end

  def make_valid_date_objects(rover_camera_sols)
    rover_camera_sols.each do |rover_and_cam, sol_text_array|
      rover, cam = rover_and_cam.split("-")
      new_rover_date = ValidRoverDate.new(rover: rover, camera: cam, sols: sol_text_array.join(","))
      new_rover_date.save
    end
  end

  def push_or_new_array(rover_camera_sols, rover_camera_type, sol)
    if rover_camera_sols[rover_camera_type] == nil
      rover_camera_sols[rover_camera_type] = [sol]
    else
      rover_camera_sols[rover_camera_type].push(sol)
    end

    return rover_camera_sols
  end

  def rover_names
    %w(Curiosity Spirit Opportunity)
  end

end
