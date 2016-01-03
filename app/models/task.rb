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

  validates :status, presence: true
  validates :type, presence: true

  default_scope{order(:created_at)}
  scope :active, ->{where(status: %w(scheduled running))}

  delegate :service_api, to: :build

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

private

  def process_event_data(data)
    %i(scheduled_at started_at finished_at).each do |key|
      next unless (timestamp = data[key.to_s])

      self[key] ||= Time.from_stamp(timestamp)
    end
  end
end
