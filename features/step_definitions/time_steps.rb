Given /^today is "([^\"]*)"$/ do |time_string|
  Timecop.travel(Time.parse(time_string))
end

