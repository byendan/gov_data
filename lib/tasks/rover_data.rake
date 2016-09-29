include GovApi
desc: "Update available options for rover data"
task: :rover_data do



  curiosity_cams = ['fhaz', 'rhaz', 'mast', 'chemcam', 'mahli', 'mardi', 'navcam']
  opp_and_spirit_cams = ['fhaz', 'rhaz', 'navcam', 'pancam', 'minites']
  rovers_with_cams = {
    'curiosity'   => curiosity_cams,
    'opportunity' => opp_and_spirit_cams,
    'spirit'      => opp_and_spirit_cams
  }

  start_date = 2012-08-06
  # nasa date year-month-day

end

def days_in_month
  return {
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
  }
end
