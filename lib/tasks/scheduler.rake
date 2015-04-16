desc "This task is called by the Heroku scheduler add-on"

task :clear_demos => :environment do
  User.where(provider: "Demo").where(created_at: < 24.hours.ago).destroy_all
end
