# Queries for all active tasks (scheduled, running) belonging to an owner or build.
class ActiveTasksQuery < Query
  delegate :count, to: :scope

  def initialize(owner_or_build)
    @owner_or_build = owner_or_build
  end

protected

  attr_reader :owner_or_build

private

  def scope
    owner_or_build.tasks.active
  end
end
