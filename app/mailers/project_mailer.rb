class ProjectMailer < ActionMailer::Base
  helper :application

  default from: "jeff.a.talbot@gmail.com"

  def daily_email(project)
    @project = project
    mail(
      :to => project.email,
      :subject => "#{project.name} Pivotal Queue: #{Time.now.strftime('%m/%d/%Y')}"
    )
  end
end
