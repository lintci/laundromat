# Connects a task to the source files it will run against.
class TaskSourceFile < ActiveRecord::Base
  belongs_to :task
  belongs_to :source_file

  default_scope{order(:created_at)}
end
