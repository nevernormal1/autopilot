module Notifier
  class Daily
    def self.run
      Project.all.each do |project|
        ProjectMailer.daily_email(project).deliver
      end
    end
  end
end
