class Task < ActiveRecord::Base
  belongs_to :build

  aasm column: :status do
    state :queued, initial: true
    state :running
    state :success
    state :failed

    event(:run){transitions from: :queued, to: :running}
    event(:succeed){transitions from: :running, to: :success}
    event(:fail){transitions from: :running, to: :failed}
  end
end
