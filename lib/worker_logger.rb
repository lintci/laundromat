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

    if Sidekiq.server?
      Sidekiq.logger.info(data)
    else
      Rails.logger.info(data)
    end
  end

private

  def strip_urls(payload)
    payload.reduce({}) do |new_payload, (key, value)|
      case value
      when String
        new_payload[key] = value unless key =~ /_url$/
      when Hash
        new_payload[key] = strip_urls(payload)
      when Array
        new_payload[key] = if value.first.is_a?(Hash)
          value.map{|v| strip_urls(v)}
        else
          value
        end
      else
        new_payload[key] = value
      end
    end
  end
end
