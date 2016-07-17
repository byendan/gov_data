module ApiModulesHelper
  def is_image?(value)
    image_types = ['jpg','png','jpeg','gif','tif','bmp']
    values = value.split('.')

    image_types.each do |i_type|
      return true if values.include?(i_type)
    end

    return false
  end
end
