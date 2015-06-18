# Issues found for source files
class Violation < ActiveRecord::Base
  belongs_to :source_file, required: true
  has_one :task_result
  has_one :task, through: :task_result

  validates :line, presence: true
  validates :message, presence: true
end
