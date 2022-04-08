# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# .zshrcとrbenvのパスを指定するrakeを定義
job_type :rake, "source /Users/docha/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

# 一時間毎に実行
every :hour do
  rake 'article_state_check:article_state'
end

# 毎日午前9時に実行
# every 1.day, at: '9:00 am' do
#   runner "Batch::Qiita.run"
# end