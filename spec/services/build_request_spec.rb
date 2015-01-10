require 'spec_helper'

describe BuildRequest do
  describe '.call' do
    let(:event){'pull_request'}
    let(:payload_data){json_fixture_file('github/pull_request_opened_payload.json')}
    before(:each){create(:repository)}

    it 'creates a build' do
      expect do
        described_class.call(event, payload_data)
      end.to change{Build.count}.by(1)
    end

    it 'schedules a classification task' do
      expect_any_instance_of(TaskScheduler).to receive(:schedule_classification)

      described_class.call(event, payload_data)
    end
  end
end
