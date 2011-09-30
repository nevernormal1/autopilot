ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app1284337@heroku.com'],
  :password       => ENV['n98imgr0'],
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp

