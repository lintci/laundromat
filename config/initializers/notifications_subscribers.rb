require 'worker_logger'

ActiveSupport::Notifications.subscribe 'app.worker.perform', WorkerLogger.new
ActiveSupport::Notifications.subscribe 'app.worker.enqueue', WorkerLogger.new
