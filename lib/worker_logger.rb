# Subscribes to wokers and logs them
class WorkerLogger
  def call(name, started, finished, unique_id, message)
    data = {
      name: name,
      started: started.stamp,
      finished: finished.stamp,
      duration: finished - started,
      notification: unique_id,
      message: message
    }

    if Sidekiq.server?
      Sidekiq.logger.info(data)
    else
      Rails.logger.info(data)
    end
  end
end
