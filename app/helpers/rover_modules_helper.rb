module RoverModulesHelper

  def has_more_pictures(picture_count)
    picture_count % 25 == 0
  end

end
