class Project < ActiveRecord::Base
  validates_presence_of :pivotal_id
  validates_presence_of :name
  validates_presence_of :token
  validates_presence_of :email

  def backlog
    project.backlog
  end

  private
  def project
    @project ||= TrackerWrapper::Project.new(token, pivotal_id)
  end
end
