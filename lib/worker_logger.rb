class WorkerLogger
  def call(name, started, finished, unique_id, payload)
    data = {
      name: name,
      started: started,
      finished: finished,
      duration: finished - started,
      notification: unique_id,
      payload: payload
    }

    if Sidekiq.server?
      Sidekiq.logger.info(data)
    else
      Rails.logger.info(data)
    end
  end
end
