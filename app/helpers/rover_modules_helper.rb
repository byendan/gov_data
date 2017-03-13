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


  def rover_names
    %w(Curiosity Spirit Opportunity)
  end



end
