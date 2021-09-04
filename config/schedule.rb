# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require File.expand_path("#{File.dirname(__FILE__)}/environment")
rails_env = ENV['RAILS_ENV'] || :production
set :environment, rails_env
set :output, 'log/cron.log'

every 1.days, at: '10:00 pm' do
  rake 'admin_report:mail_admin_report'
end

#every 1.days, at: '10:00 pm' do
#  Event.where('start_time < ?', Date.today).where(status: false).update(status: true)
#end
