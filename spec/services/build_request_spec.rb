require 'spec_helper'

describe BuildRequest do
  describe '.call' do
    let(:event){'pull_request'}
    let(:event_id){'bdb6ec00-5284-11e4-8e22-6dacd62599e2'}
    let(:payload_data){json_fixture_file('github/pull_request_opened_payload.json')}
    before(:each){create(:repository)}

    it 'creates a build' do
      expect do
        described_class.call(event, event_id, payload_data)
      end.to change{Build.count}.by(1)
    end

    it 'schedules a classification task' do
      expect_any_instance_of(TaskScheduler).to receive(:schedule_classification)

      described_class.call(event, event_id, payload_data)
    end
  end
end
