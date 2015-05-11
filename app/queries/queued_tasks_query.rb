# Queries for all queued tasks belonging to an owner or build.
class QueuedTasksQuery < Query
  delegate :find_each, to: :scope

  def initialize(owner_or_build)
    @owner_or_build = owner_or_build
  end

protected

  attr_reader :owner_or_build

private

  def scope
    owner_or_build.tasks.queued
  end
end
