require 'spec_helper'

describe TaskScheduler do
  let(:build){create(:build)}
  subject(:scheduler){described_class.new(build)}

  describe '#schedule_analysis' do
    it 'creates a analyze task' do
      expect do
        scheduler.schedule_analysis
      end.to change{build.tasks.size}.by(1)

      task = Task.last
      expect(task).to be_a(AnalyzeTask)
      expect(task.language).to eq('All')
      expect(task.tool).to eq('Linguist')
    end

    it 'schedules the task to be run' do
      expect do
        scheduler.schedule_analysis
      end.to change(AnalyzeTaskRequestedWorker.jobs, :size).by(1)

      job = AnalyzeTaskRequestedWorker.jobs.last
      expect(job['args']).to match([
        {
          'analyze_task'  =>  {
            'id' => be_a(Integer),
            'type' => 'AnalyzeTask',
            'status' => 'scheduled',
            'language' => 'All',
            'tool' => 'Linguist',
            'build' => {
              'id' => be_a(Integer),
              'pull_request' => {
                'id' => 1,
                'base_sha' => 'bbf813a806dacf043a592f04a0ed320236caca3a',
                'head_sha' => '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
                'branch' => 'mostly-bad',
                'clone_url' => 'git://github.com/lintci/guinea_pig.git',
                'owner' => 'lintci',
                'repo' => 'guinea_pig'
              }
            }
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'requested_at' => be_timestamp
          }
        }
      ])
    end
  end

  describe '#schedule_linting' do
    let(:group){FactoryGirl.build(:source_file_group)}

    it 'creates a lint task' do
      expect do
        scheduler.schedule_linting(group)
      end.to change{build.tasks.size}.by(1)

      task = Task.last
      expect(task).to be_a(LintTask)
      expect(task.language).to eq('Ruby')
      expect(task.tool).to eq('RuboCop')
    end

    it 'schedules the task to be run' do
      expect do
        scheduler.schedule_linting(group)
      end.to change{LintTaskRequestedWorker.jobs.size}.by(1)

      job = LintTaskRequestedWorker.jobs.last
      expect(job['args']).to match([
        {
          'lint_task'  =>  {
            'id' => be_a(Integer),
            'type' => 'LintTask',
            'status' => 'scheduled',
            'language' => 'Ruby',
            'tool' => 'RuboCop',
            'build' => {
              'id' => be_a(Integer),
              'pull_request' => {
                'id' => 1,
                'base_sha' => 'bbf813a806dacf043a592f04a0ed320236caca3a',
                'head_sha' => '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
                'branch' => 'mostly-bad',
                'clone_url' => 'git://github.com/lintci/guinea_pig.git',
                'owner' => 'lintci',
                'repo' => 'guinea_pig'
              }
            },
            'source_files' => [
              {
                'id' => be_a(Integer),
                'name' => 'bad.rb',
                'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
                'source_type' => 'Ruby',
                'language' => 'Ruby',
                'linters' => ['RuboCop'],
                'modified_lines' => [1, 2, 3, 4],
                'extension' => '.rb',
                'size' => 31,
                'generated' => false,
                'vendored' => false,
                'documentation' => false,
                'binary' => false,
                'image' => false
              }
            ]
          },
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'requested_at' => be_timestamp
          }
        }
      ])
    end
  end
end
