require 'command_service'

# Triggers a build to run
class RequestBuild < CommandService
  def initialize(data)
    @event = data['meta']['event']
    @event_id = data['meta']['event_id']
    @payload = Payload.new(data['payload'])
  end

  def perform
    build = create_build

    schedule_build_tasks(build)

    mark_pull_request_pending
  end

protected

  attr_reader :event, :event_id, :payload

private

  delegate :service_api, to: :repository

  def create_build
    repository.create_build!(event, event_id, payload)
  end

  def schedule_build_tasks(build)
    TaskScheduler.new(build).schedule_analysis
  end

  def mark_pull_request_pending

  end

  def repository
    @repository ||= Repository.includes(:owner).find_by(name: payload.repository, owner_name: payload.owner)
  end
end
