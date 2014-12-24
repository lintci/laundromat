class BuildRequest
  def initialize(event, payload_data)
    @event = event
    @payload = Payload.new(payload_data)
  end

  def call
    ActiveRecord::Base.transaction do
      build = create_build

      schedule_build_tasks(build)
    end
  end

protected

  attr_reader :event, :payload

private

  def create_build
    repository.builds.create!(event: event, payload: payload)
  end

  def schedule_build_tasks(build)
    TaskScheduler.new(build).schedule_categorization
  end

  def repository
    @repository ||= Repository.includes(:owner).find_by(full_name: payload.full_name)
  end
end
