desc "This task is called by the Heroku scheduler add-on"
task :clear_demos => :environment do
  User.where(provider: "Demo").destroy_all
end
