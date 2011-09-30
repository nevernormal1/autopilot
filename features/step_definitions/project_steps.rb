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
  xml = build_project(@project)
  stub_request(
    :any,
    "https://www.pivotaltracker.com/services/v3/projects/#{@project.pivotal_id}"
  ).to_return(
    :body => xml,
    :status => 200
  )

  stub_request(
    :any,
    "https://www.pivotaltracker.com/services/v3/projects/#{@project.pivotal_id}/stories"
  ).with(
    :query => {"filter" => "current_state:unstarted story_type:feature,chore,bug"}
  ).to_return(
    :body => build_stories(table),
    :status => 200
  )
end

private
def build_project(project)
  builder = Builder::XmlMarkup.new
  builder.instruct!
  builder.project do |xml_project|
    xml_project.id project.pivotal_id
    xml_project.name project.name
  end
end

def build_stories(story_table)
  builder = Builder::XmlMarkup.new
  builder.instruct!
  builder.stories do |stories|
    story_table.hashes.each do |row|
      next if row['Type'] =~ /release/i
      stories.story do |story|
        story.name row['Name']
        story.description row['Description']
        story.estimate row['Estimate']
        story.story_type row['Type']
        story.current_state row['State']
      end
    end
  end
end
