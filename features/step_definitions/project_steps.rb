require 'builder'

Given /^I have the following project:$/ do |table|
  table.hashes.each do |row|
    @project = Project.create!(
      :name => row['Name'],
      :token => row['Token'],
      :email => row['Email'],
      :pivotal_id => row['Pivotal ID']
    )
  end
end

Given /^my project has the following stories in the backlog:$/ do |table|
  xml = build_stories(table)
  stub_request(:any, "https://www.pivotaltracker.com/services/v3/projects/#{@project.pivotal_id}/stories?filter=state:unstarted").to_return(
    :body => xml,
    :status => 200
  )
end

private
def build_stories(story_table)
  builder = Builder::XmlMarkup.new
  builder.stories do |stories|
    story_table.hashes.each do |row|
      builder.story do |story|
        story.name = row['Name']
        story.description = row['Description']
        story.estimate = row['Estimate']
        story.type = row['Type']
        story.state = row['State']
      end
    end
  end
end
