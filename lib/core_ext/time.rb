class Time
  class << self
    def from_stamp(timestamp)
      Time.iso8601(timestamp)
    end

    def stamp(time = now)
      time.stamp
    end
  end

  def stamp
    utc.iso8601
  end
end
