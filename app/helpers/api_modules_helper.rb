module ApiModulesHelper

  def is_image?(value)
    image_types = ['jpg','png','jpeg','gif','tif','bmp']
    values = value.split('.')

    image_types.each do |i_type|
      return true if values.include?(i_type)
    end

    return false
  end

  def information_for(graph_type, module_data, options = {})
    presenter = ApiModulePresenter.new(graph_type, module_data, self, options)
    if block_given?
      yield(presenter)
    else
      presenter
    end
  end

end
