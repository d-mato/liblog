source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

########################################
# DB
gem 'pg'

gem 'active_decorator'
gem 'activeadmin'
gem 'bootstrap'
gem 'devise'
gem 'devise-i18n'
gem 'jquery-rails'
gem 'mechanize'
gem 'pry-rails'
gem 'rails-i18n'
gem 'ridgepole'
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
  gem 'rspec-rails'
end
