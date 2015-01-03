require 'spec_helper'

describe StartTask do
  subject(:task){create(:categorization_task)}
  let(:started_at){iso8601_time(Time.now)}
  let(:data){{'task_id' => task.id, 'started_at' => started_at.iso8601}}

  describe '.call' do
    it 'updates the started_at and sets the state to running' do
      StartTask.call(data)

      task.reload
      expect(task.started_at).to eq(started_at)
    end

    it 'sets the status to running' do
      StartTask.call(data)

      task.reload
      expect(task.status).to eq('running')
    end
  end
end
