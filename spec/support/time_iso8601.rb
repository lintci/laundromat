module TimeISO8601
  def iso8601_time(time)
    Time.iso8601(time.iso8601)
  end
end

include TimeISO8601
