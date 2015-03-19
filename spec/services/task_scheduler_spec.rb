require 'spec_helper'

describe TaskScheduler do
  let(:build){create(:build)}
  subject(:scheduler){described_class.new(build)}

  describe '#schedule_classification' do
    it 'creates a classify task' do
      expect do
        scheduler.schedule_classification
      end.to change{build.tasks.size}.by(1)

      task = Task.last
      expect(task).to be_a(ClassifyTask)
      expect(task.language).to eq('All')
      expect(task.tool).to eq('Linguist')
    end

    it 'schedules the task to be run' do
      expect do
        scheduler.schedule_classification
      end.to change(ClassifyTaskRequestedWorker.jobs, :size).by(1)

      job = ClassifyTaskRequestedWorker.jobs.last
      expect(job['args']).to match([{
        'classify_task'  =>  {
          'id' => be_a(Integer),
          'type' => 'ClassifyTask',
          'status' => 'queued',
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
      }])
    end
  end

  describe '#schedule_linting' do
    let(:group){FactoryGirl.build(:group)}

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
      expect(job['args']).to match([{
        'lint_task'  =>  {
          'id' => be_a(Integer),
          'type' => 'LintTask',
          'status' => 'queued',
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
          'modified_files' => [{'name' => 'bad.rb', 'lines' => [1, 2, 3, 4]}]
        },
        'meta' => {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'requested_at' => be_timestamp
        }
      }])
    end
  end
end
