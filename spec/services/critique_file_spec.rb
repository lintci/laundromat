require 'spec_helper'

describe CritiqueFile do
  describe '#call' do
    let(:started_at){Time.stamp_time}
    let(:finished_at){Time.stamp_time}
    let!(:task){create(:lint_task, :running, :with_source_files)}
    let!(:source_file){task.source_files.last}
    let(:file_linted_event) do
      build(:file_linted, lint_task: task, source_file: source_file, started_at: started_at, finished_at: finished_at)
    end

    subject(:service){described_class}

    it 'records the violations and comments on the pull request' do
      expect_any_instance_of(Payload::PullRequest).to receive(:comment).once.with(
        source_file,
        2,
        contain_exactly(be_a(Violation), be_a(Violation))
      )

      service.call(file_linted_event)

      expect(source_file.violations.size).to eq(2)
      expect(task.violations.size).to eq(2)

      task_source_files = task.task_source_files
      expect(task_source_files.size).to eq(1)
      expect(task_source_files.last.started_at).to eq(started_at)
      expect(task_source_files.last.finished_at).to eq(finished_at)
    end
  end
end
