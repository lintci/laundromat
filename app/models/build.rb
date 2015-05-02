# A collection of tasks to perform for events like pull requests
class Build < ActiveRecord::Base
  belongs_to :repository, required: true

  has_many :tasks
  has_many :source_files

  validates :event, :event_id, :payload, presence: true

  delegate :owner, to: :repository
  delegate :status, to: :tasks

  def create_analyze_task
    tasks.create!(type: 'AnalyzeTask', language: 'All', tool: 'Linguist')
  end

  def create_lint_task(group)
    tasks.create!(
      type: 'LintTask',
      language: group.language,
      tool: group.tool,
      source_files: group.source_files
    )
  end

  def payload=(payload)
    self[:payload] = payload.is_a?(Payload) ? payload.data : payload
  end

  def payload
    return unless self[:payload]

    Payload.new(self[:payload])
  end
end
