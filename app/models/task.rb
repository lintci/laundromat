class Task < ActiveRecord::Base
  include AASM

  belongs_to :build, required: true

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

    event(:start){transitions from: :queued, to: :running, after: :process_start_event}
    event(:succeed){transitions from: :running, to: :success, after: :process_finish_event}
    event(:fail){transitions from: :running, to: :failed, after: :process_finish_event}
  end

private

  def process_start_event(started_at)
    self.started_at = started_at
  end

  def process_finish_event(finished_at)
    self.finished_at = finished_at
  end
end
