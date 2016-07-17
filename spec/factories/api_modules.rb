FactoryGirl.define do
  factory :api_module do
    name       {"nasa is awesome"}
    url        {"nasa.com"}
    graph_type {"picture"}
    desired_data {"title,hdurl,explanation,media_type"}
  end

end
