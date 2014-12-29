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

    event(:start){transitions from: :queued, to: :running}
    event(:succeed){transitions from: :running, to: :success}
    event(:fail){transitions from: :running, to: :failed}
  end
end
