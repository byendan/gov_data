class ApiModule < ActiveRecord::Base
  store :options, accessors: [], coder: JSON
end
