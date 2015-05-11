require 'spec_helper'

describe ProcessLinting do
  let(:task){create(:lint_task, :running, :with_source_files)}
  let(:finished_at){Time.stamp_time}
  subject(:service){described_class}

  describe '.call' do
    context 'when the linting is successful' do
      let(:lint_task_completed) do
        build(:lint_task_completed, task_id: task.id, clean: true, finished_at: finished_at)
      end

      it 'updates the tasks status to success' do
        service.call(lint_task_completed)

        expect(task.reload).to be_success
        expect(task.finished_at).to eq(finished_at)
      end
    end

    context 'when the linting failed' do
      let(:lint_task_completed) do
        build(:lint_task_completed, task_id: task.id, clean: false, finished_at: finished_at)
      end

      it 'updates the tasks status to failure' do
        service.call(lint_task_completed)

        expect(task.reload).to be_failed
        expect(task.finished_at).to eq(finished_at)
      end
    end

    context 'when other tasks are queued' do
      let(:lint_task_completed){build(:lint_task_completed, task_id: task.id)}
      let!(:queued_task){create(:lint_task, :queued, build: task.build)}

      it 'schedules the other tasks' do
        expect_any_instance_of(TaskScheduler).to receive(:schedule).with(queued_task)

        service.call(lint_task_completed)
      end
    end
  end
end
