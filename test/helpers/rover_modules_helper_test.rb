class RoverModulesHelperTest < ActionView::TestCase
  include RoverModulesHelper

  test "has more pictures returns true if more than 25" do
    more_than_twenty_five_pictures = 30
    has_more_pictures_result = has_more_pictures(more_than_twenty_five_pictures)
    assert has_more_pictures_result
  end

  test "has more pictures returns false if less than 25" do
    less_than_twenty_five_pictures = 20
    has_more_pictures_result = has_more_pictures(less_than_twenty_five_pictures)
    assert_not has_more_pictures_result, "The result is #{has_more_pictures_result}"
  end

  test "retrieve manifests for all three rovers" do
    # Makes three network requests, only run if needed
    skip

    rovers = rover_names
    manifests = []
    expected_total_manifests = rovers.length

    # ensure everything went correctly and we are looking for 3 manifests
    assert_equal 3, expected_total_manifests

    rovers.each {|rover| manifests << get_manifest(rover)}

    assert_equal expected_total_manifests, manifests.length
  end

  test "retrieve manifests using mocks" do

    stubs(:get_manifest).with do |rover_name|
      return File.read("test/fixtures/#{rover_name}_sample_manifest.json")
    end

    rovers = rover_names
    manifests = []
    expected_total_manifests = rovers.length

    rovers.each do |rover|
      manifests.push(get_manifest(rover))
    end
    assert_equal expected_total_manifests, manifests.length
  end

  test "log my manifests" do
    # Helper to store the manifests makes three network requests
    skip
    log_mainfests
    assert true
  end

end
