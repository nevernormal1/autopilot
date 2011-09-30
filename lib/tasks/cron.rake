task :cron => :environment do
  Notifier::Daily.run
end
