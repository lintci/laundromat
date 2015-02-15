require 'worker_logger'

ActiveSupport::Notifications.subscribe(/app\.worker/, WorkerLogger.new)
