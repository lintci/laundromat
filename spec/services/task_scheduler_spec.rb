require 'spec_helper'

describe TaskScheduler do
  let(:build){create(:build)}
  subject(:scheduler){described_class.new(build)}

  describe '#schedule_classification' do
    it 'creates a classification task' do
      expect do
        scheduler.schedule_classification
      end.to change{build.tasks.size}.by(1)
    end

    it 'schedules the task to be run' do
      expect do
        scheduler.schedule_classification
      end.to change(ClassifyTaskRequestedWorker.jobs, :size).by(1)
    end
  end
end
