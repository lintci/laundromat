require 'spec_helper'

describe StartTask do
  subject(:service){}
  let(:task){create(:classify_task)}
  let(:started_at){Time.stamp}
  let(:started_at_time){Time.from_stamp(started_at)}
  let(:data){build(:task_started_event, task: task, started_at: started_at_time)}

  describe '.call' do
    it 'updates the started_at and sets the state to running' do
      described_class.call(data)

      task.reload
      expect(task.started_at).to eq(started_at)
    end

    it 'sets the status to running' do
      described_class.call(data)

      task.reload
      expect(task.status).to eq('running')
    end
  end
end
