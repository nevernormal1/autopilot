class ProjectMailer < ActionMailer::Base
  default from: "development@inventables.com"

  def daily_email(project)
    @project = project
    mail(
      :to => project.email,
      :subject => "#{project.name} Pivotal Queue"
    )
  end
end
