class CritiqueFile < CommandService
  def initialize(data)
    @data = data
  end

  def call
    transaction do

    end
  end

protected

  attr_reader :data

private

  def task
    @task ||= Task.find(data['task_id'])
  end

  def build
    task.build
  end
end
