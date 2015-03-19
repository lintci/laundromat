class Build < ActiveRecord::Base
  belongs_to :repository, required: true
  has_many :tasks

  validates_presence_of :event, :event_id, :payload

  delegate :owner, to: :repository
  delegate :status, to: :tasks

  def create_classify_task
    tasks.create!(type: 'ClassifyTask', language: 'All', tool: 'Linguist')
  end

  def create_lint_task(group)
    task = tasks.build(type: 'LintTask', language: group.language, tool: group.linter)
    task.add_modified_files(group)
    task.save!
    task
  end

  def payload=(payload)
    self[:payload] = payload.is_a?(Payload) ? payload.data : payload
  end

  def payload
    return unless self[:payload]

    Payload.new(self[:payload])
  end

  def status
    tasks.status
  end
end
