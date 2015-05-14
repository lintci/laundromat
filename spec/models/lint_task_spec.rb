require 'rails_helper'

RSpec.describe LintTask, type: :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:lint_task, :queued)}
    let(:scheduled_task){build(:lint_task, :scheduled)}
    let(:running_task){build(:lint_task, :running)}
  end

  describe '#add_violations' do
    let!(:source_file){create(:source_file, tasks: [task])}
    let(:violations){[build(:violation)]}
    let(:started_at){Time.stamp_time}
    let(:finished_at){Time.stamp_time}
    subject(:task){create(:lint_task, :running)}

    it 'adds violations to the source file' do
      expect(source_file).to receive(:add_violations).with(violations)

      task.add_violations(source_file, violations, started_at, finished_at)
    end

    it 'adds violations to itself' do
      task.add_violations(source_file, violations, started_at, finished_at)

      expect(task.violations).to eq(violations)
    end

    it 'sets the started_at and finished_at for how long the file took to lint' do
      task.add_violations(source_file, violations, started_at, finished_at)

      task_source_file = task.task_source_files.last
      expect(task_source_file.started_at).to eq(started_at)
      expect(task_source_file.finished_at).to eq(finished_at)
    end
  end
end
