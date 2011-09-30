module TrackerWrapper
  class Project
    def initialize(token, pivotal_id)
      @token = token
      @pivotal_id = pivotal_id
    end

    def backlog
      @backlog ||= project.stories.all(:current_state => 'unstarted', :story_type => ['feature', 'chore', 'bug'])
    end

    def project
      @project ||= retrieve_project
    end

    private
    def retrieve_project
      PivotalTracker::Client.use_ssl = true
      PivotalTracker::Client.token = @token
      PivotalTracker::Project.find(@pivotal_id)
    end
  end
end
