source 'https://rubygems.org'

ruby '2.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'sidekiq'
gem 'aasm'
gem 'active_model_serializers', '~> 0.8.0'
gem 'octokit'
gem 'stamped'

gem 'foreman'
gem 'puma'
gem 'rails_12factor', group: :production
gem 'newrelic_rpm'
gem 'sentry-raven', group: :production
gem 'le'
gem 'skylight'
gem 'sidekiq-skylight'
gem 'sidekiq-notifications'
gem 'lograge'
gem 'virtus'

gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'pry-rails'
gem 'pry-byebug'

group :development, :test do
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

group :test do
  gem 'rspec-its'
  gem 'factory_girl_rails'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov'
end

group :development do
  gem 'rails-erd'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
