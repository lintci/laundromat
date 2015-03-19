require 'spec_helper'

describe CompleteClassifyTask do
  describe '#call' do
    let(:task){create(:classify_task, :running)}
    let(:finished_at){Time.stamp_time}
    let(:group){build(:group)}
    let(:data) do
      {
        'classification' => {
          'task_id' => task.id,
          'groups' => [
            {
              'linter' => 'RuboCop',
              'language' => 'Ruby',
              'modified_files' => [{'name' => 'bad.rb', 'lines' => [1, 2, 3, 4]}]
            },
            {
              'linter' => 'Unknown',
              'language' => 'Text',
              'modified_files' => [{'name' => 'lint.txt', 'lines' => [1]}]
            }
          ]
        },
        'meta' =>  {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'started_at' => task.started_at.stamp,
          'finished_at' => finished_at.stamp
        }
      }
    end

    it 'transitions the classify task to success' do
      described_class.call(data)

      task.reload
      expect(task.finished_at).to eq(finished_at)
      expect(task.status).to eq('success')
    end

    it 'schedules the linting tasks' do
      expect_any_instance_of(TaskScheduler).to receive(:schedule_linting).with(group)

      described_class.call(data)
    end
  end
end
