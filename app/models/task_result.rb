# Connects tasks to violations
class TaskResult < ActiveRecord::Base
  belongs_to :task
  belongs_to :violation
end
