class ApiModule < ActiveRecord::Base
  store :options, accessors: [], coder: JSON


  def get_graph_types
    return ["picture", "galery", "line", "bar"]
  end
end
