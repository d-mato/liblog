source 'https://rubygems.org'
ruby '2.5.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 6.0.0'
gem 'puma', '~> 4.1'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.9'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

########################################
# DB
gem 'pg'

gem 'active_decorator'
gem 'devise'
gem 'devise-i18n'
gem 'exception_notification'
gem 'mechanize'
gem 'pry-rails'
gem 'rails-i18n'
gem 'ridgepole'
gem 'sidekiq'
gem 'slim-rails'
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
