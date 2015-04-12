# Connects tasks to source files
class TaskResult < ActiveRecord::Base
  belongs_to :task
  belongs_to :source_file
end
