class Task < ActiveRecord::Base
  include AASM

  belongs_to :build, required: true
  has_many :task_results
  has_many :source_files, through: :task_results

  validates_presence_of :status, :type

  class << self
    def total_running
      running.count
    end

    def status
      if any?(&:failed?)
        :failed
      elsif any?(&:running?)
        :running
      elsif any?(&:queued?)
        :queued
      else
        :success
      end
    end
  end

  aasm column: :status do
    state :queued, initial: true
    state :running
    state :success
    state :failed

    event(:start){transitions from: :queued, to: :running, after: :process_event_data}
    event(:succeed){transitions from: %i(queued running), to: :success, after: :process_event_data}
    event(:failure){transitions from: %i(queued running), to: :failed, after: :process_event_data}
  end

private

  def process_event_data(data)
    %i(started_at finished_at).each do |key|
      next unless (timestamp = data[key.to_s])

      self[key] ||= Time.from_stamp(timestamp)
    end
  end
end
