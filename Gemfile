source 'https://rubygems.org'
ruby '3.0.0' # herokuはここを見てRubyのバージョンを特定するので指定する

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 7.0'
gem 'puma', '~> 4.3'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.10'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'better_errors'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

########################################
# DB
gem 'pg'

gem 'active_decorator'
gem 'bcrypt'
gem 'capybara'
gem 'exception_notification'
gem 'mechanize'
gem 'webrick' # mechanizeが依存しているがRuby3から削除されたので追加する
gem 'pry-rails'
gem 'rails-i18n'
gem 'ridgepole'
gem 'slack-notifier'
gem 'slim-rails'
gem 'webdrivers'
gem 'webpacker'
gem 'whenever', require: false

group :development, :test do
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
  gem 'capistrano3-ridgepole'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'letter_opener'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
end
