require 'spec_helper'

describe RequestBuild do
  describe '.call' do
    let(:payload_received){build(:payload_received)}
    let(:event){build(:event)}
    let(:event_id){build(:event_id)}
    let(:payload){build(:payload)}
    before(:each){create(:repository)}

    it 'creates a build' do
      expect do
        described_class.call(payload_received)
      end.to change{Build.count}.by(1)

      build = Build.last
      expect(build.event).to eq(event)
      expect(build.event_id).to eq(event_id)
      expect(build.payload).to eq(payload)
    end

    it 'schedules a classification task' do
      expect_any_instance_of(TaskScheduler).to receive(:schedule_classification)

      described_class.call(payload_received)
    end
  end
end
