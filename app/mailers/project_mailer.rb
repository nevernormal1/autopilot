class ProjectMailer < ActionMailer::Base
  default from: "development@inventables.com"

  def daily_email(project)
    mail(
      :to => project.email,
      :subject => "Your #{project.name} backlog"
    )
  end
end
