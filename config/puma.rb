require 'envee'

workers ENV.int('WEB_CONCURRENCY', 1)
threads_count = ENV.int('MAX_THREADS', 5)
threads threads_count, threads_count

preload_app!

rackup DefaultRackup
port ENV.int('PORT', 8080)
environment ENV.str('RACK_ENV', 'development')

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
