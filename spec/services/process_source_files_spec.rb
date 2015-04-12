require 'spec_helper'

describe ProcessSourceFiles do
  describe '#call' do
    let(:task){create(:classify_task, :running)}
    let(:finished_at){Time.stamp_time}
    let(:data) do
      {
        'classification' => {
          'task_id' => task.id,
          'source_files' => [{
            'name' => 'bad.rb',
            'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
            'language' => 'Ruby',
            'linters' => ['RuboCop'],
            'modified_lines' => [1, 2, 3, 4],
            'source_type' => 'Ruby',
            'size' => 31,
            'extension' => '.rb',
            'binary' => false,
            'generated' => false,
            'vendored' => false,
            'documentation' => false,
            'image' => false
          }, {
            'name' => 'lint.txt',
            'sha' => 'dfea5994965f3bc2e0adaa57922f30b11c5bcf13',
            'language' => 'Text',
            'linters' => ['Unknown'],
            'modified_lines' => [1],
            'source_type' => 'Text',
            'size' => 5,
            'extension' => '.txt',
            'binary' => false,
            'generated' => false,
            'vendored' => false,
            'documentation' => false,
            'image' => false
          }]
        },
        'meta' => {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'started_at' => Time.stamp,
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
      expect_any_instance_of(TaskScheduler).to receive(:schedule_linting) do |_, group|
        expect(group.tool).to eq('RuboCop')
        expect(group.language).to eq('Ruby')
        expect(group.source_files.size).to eq(1)
      end

      described_class.call(data)
    end
  end
end
