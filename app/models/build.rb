class Build < ActiveRecord::Base
  belongs_to :repository
  has_many :tasks

  def create_categorization_task
    tasks.create!(type: 'CategorizationTask', language: 'All', linter: 'None')
  end

  def create_analysis_task(language, linter)
    tasks.create!(type: 'AnalysisTask', language: language, linter: linter)
  end

  def payload=(payload)
    self[:payload] = payload.is_a?(Payload) ? payload.data : payload
  end

  def payload
    Payload.new(self[:payload])
  end
end
