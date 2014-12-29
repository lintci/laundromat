require 'spec_helper'

describe TaskScheduler do
  let(:build){create(:build)}
  subject(:scheduler){described_class.new(build)}

  describe '#schedule_categorization' do
    it 'creates a categorization task' do
      expect do
        scheduler.schedule_categorization
      end.to change{build.tasks.size}.by(1)
    end

    it 'schedules the task to be run' do
      expect do
        scheduler.schedule_categorization
      end.to change(CategorizationTaskRequestedWorker.jobs, :size).by(1)
    end
  end
end
