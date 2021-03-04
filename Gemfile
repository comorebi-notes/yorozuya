source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

# View
gem 'haml-rails'

# Debug
gem 'awesome_print'

# Session
gem 'devise'

# Data
gem 'timecop'

# Notification
gem 'exception_notification'
gem 'slack-notifier'

# Setting
gem 'config'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Setting
  gem 'dotenv-rails'

  # Debug
  gem 'better_errors'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'

  # rubocop
  gem 'rubocop', '~> 1.3', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
end

group :test do
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'

  # Data
  gem 'annotate'
  gem 'bullet'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
