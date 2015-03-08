require 'spec_helper'

describe TaskScheduler do
  let(:build){create(:build)}
  subject(:scheduler){described_class.new(build)}

  describe '#schedule_classification' do
    it 'creates a classification task' do
      expect do
        scheduler.schedule_classification
      end.to change{build.tasks.size}.by(1)

      task = Task.last
      expect(task).to be_a(ClassifyTask)
      expect(task.language).to eq('All')
    end

    it 'schedules the task to be run' do
      expect do
        scheduler.schedule_classification
      end.to change(ClassifyTaskRequestedWorker.jobs, :size).by(1)

      job = ClassifyTaskRequestedWorker.jobs.last
      expect(job['args']).to match([{
        'task'  =>  {
          'id' => be_a(Integer),
          'type' => 'ClassifyTask',
          'status' => 'queued',
          'language' => 'All',
          'tool' => 'Linguist',
          'build' => {
            'id' => be_a(Integer),
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
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
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2'
        }
      }])
    end
  end
end
