namespace :valid_rover_dates do
  desc "Update available options for rover data"
  task rover_data: :environment do

    log = ActiveSupport::Logger.new('log/test_rake.log')
    log.info "This rake task is working"

    # if there are rover dates, find the most recent date and set the following
    # date to be the start date
    if ValidRoverDate.all.any?
      start_date = ValidRoverDates.order(:created_at).last.created_at.strftime("%Y-%m-%d")

    # if there are no rover dates set the start date to the first
    # date where rovers took pictures
    else
      start_date = "2012-08-05"
    end
    log.info "the start date has been set to #{start_date}"

    year, month, day = start_date.split("-").map(&:to_i)
    start_date = Date.new(year, month, day).next
    today = Date.today
    log.info "the start date is #{start_date}"
    log.info "todays date is #{Date.today}"

    curiosity_cams = ['fhaz', 'rhaz', 'mast', 'chemcam', 'mahli', 'mardi', 'navcam']
    opp_and_spirit_cams = ['fhaz', 'rhaz', 'navcam', 'pancam', 'minites']
    rovers_with_cams = {
      'curiosity'   => curiosity_cams,
      'opportunity' => opp_and_spirit_cams,
      'spirit'      => opp_and_spirit_cams
    }

    rovers_with_cams.each do |rover, cam_list|
      # first try rover with no cam


      #then try all the cams for the rover

    end

  end
end
