require 'command_service'

class BuildRequest < CommandService
  def initialize(event, event_id, payload_data)
    @event = event
    @event_id = event_id
    @payload = Payload.new(payload_data)
  end

  def perform
    build = create_build

    schedule_build_tasks(build)
  end

protected

  attr_reader :event, :event_id, :payload

private

  def create_build
    repository.create_build!(event, event_id, payload)
  end

  def schedule_build_tasks(build)
    TaskScheduler.new(build).schedule_classification
  end

  def repository
    @repository ||= Repository.includes(:owner).find_by(full_name: payload.full_name)
  end
end
