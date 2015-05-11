# A piece of work, such as linting to perform
class Task < ActiveRecord::Base
  include AASM

  belongs_to :build, required: true
  has_one :repository, through: :build
  has_one :owner, through: :repository
  has_many :task_source_files
  has_many :source_files, through: :task_source_files
  has_many :task_results
  has_many :violations, through: :task_results

  scope :active, ->{where(status: %w(scheduled running))}

  validates :status, :type, presence: true

  aasm column: :status do
    state :queued, initial: true
    state :scheduled
    state :running
    state :success
    state :failed

    event(:schedule){transitions from: :queued, to: :scheduled, after: :process_event_data}
    event(:start){transitions from: %i(queued scheduled), to: :running, after: :process_event_data}
    event(:succeed){transitions from: %i(scheduled running), to: :success, after: :process_event_data}
    event(:failure){transitions from: %i(scheduled running), to: :failed, after: :process_event_data}
  end

  def add_violations(source_file, new_violations, started_at, finished_at)
    source_file.add_violations(new_violations)

    task_source_file = task_source_files.find_by(source_file_id: source_file)
    task_source_file.update_attributes!(started_at: started_at, finished_at: finished_at)

    violations.push(*new_violations)
  end

private

  def process_event_data(data)
    %i(scheduled_at started_at finished_at).each do |key|
      next unless (timestamp = data[key.to_s])

      self[key] ||= Time.from_stamp(timestamp)
    end
  end
end
