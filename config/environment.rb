# Load the Rails application.
require File.expand_path('../application', __FILE__)

if Rails.env.production?
  Rails.logger = Le.new(ENV['LOGENTRIES_TOKEN'], local: STDOUT)
end

# Initialize the Rails application.
Rails.application.initialize!
