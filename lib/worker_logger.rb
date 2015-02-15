class WorkerLogger
  def call(name, started, finished, unique_id, payload)
    Rails.logger(
      name: name,
      started: started,
      finished: finished,
      duration: finished - started,
      notification: unique_id
      payload: payload
    )
  end
end
