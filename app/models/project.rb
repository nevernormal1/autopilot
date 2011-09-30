class Project < ActiveRecord::Base
  def backlog
    project.backlog
  end

  private
  def project
    @project ||= TrackerWrapper::Project.new(token, pivotal_id)
  end
end
