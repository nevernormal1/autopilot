Given /^I have the following project:$/ do |table|
  table.hashes.each do |row|
    Project.create!(
      :name => row['Name'],
      :token => row['Token'],
      :email => row['Email']
    )
  end
end

