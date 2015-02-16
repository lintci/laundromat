class WorkerLogger
  def call(name, started, finished, unique_id, payload)
    data = {
      name: name,
      started: started,
      finished: finished,
      duration: finished - started,
      notification: unique_id,
      payload: strip_urls(payload)
    }

    puts data[:payload]

    if Sidekiq.server?
      Sidekiq.logger.info(data)
    else
      Rails.logger.info(data)
    end
  end

private

  def strip_urls(payload)
    payload.each_pair.with_object({}) do |(key, value), new_payload|
      next if key =~ /_url$/

      new_payload[key] = if value.is_a?(Hash)
        strip_urls(value)
      else
        value
      end
    end
  end
end
