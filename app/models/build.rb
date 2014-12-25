class Build < ActiveRecord::Base
  belongs_to :repository, required: true
  has_many :tasks

  validates_presence_of :event, :payload

  delegate :owner, to: :repository

  def create_categorization_task
    tasks.create!(type: 'CategorizationTask', language: 'All', linter: 'None')
  end

  def create_analysis_task(language, linter, file_modifications)
    task = tasks.build(type: 'AnalysisTask', language: language, linter: linter)
    task.add_file_modifications(file_modifications)
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
end
