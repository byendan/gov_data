class ApiModulePresenter
attr_reader :decorated_module
def initialize(graph_type, module_data, template, options = {})
  @template = template
  @graph_type = graph_type
  @decorated_module = decorate(@graph_type, module_data)
end

def to_s
  @template.render partial: "api_modules/#{@graph_type}", object: self
end

def decorate(graph_type, module_data)

  return case graph_type
  when "picture"
    return decorate_picture(module_data)
  when "galery"
    return module_data
  when "line"
    return decorate_line(module_data)
  when "bar"
    return decorate_bar(module_data)
  else
    # Change to real error later
    return "error"
  end

end

def decorate_picture(module_data)
  decorated_module = Hash.new

  # set the title for the decorated module
  decorated_module["title"] = module_data["title"]
  # will try to look up with name if title returned nil
  decorated_module["title"] ||= module_data["name"]

  # set the picture url for the decorated module
  url_key = "url"
  # find the module data with a url in the name
  module_data.keys.each do |key|
    url_key = key if /.*url/ =~ key
  end
  decorated_module["picture"] = module_data[url_key]

  # set the description variable
  decorated_module["description"] = module_data["explanation"]

  return decorated_module

end

def decorate_galery(module_data)
end

def decorate_line(module_data)
end

def decorate_bar(module_data)
end

end
