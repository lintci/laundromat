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
      expect(job['args'].first).to be_json_api_resource('analyze_task').
                                   including(build: :pull_request).
                                   with_meta(
                                     event: 'pull_request',
                                     event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                     requested_at: be_timestamp
                                   )
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
      expect(job['args'].first).to be_json_api_resource('lint_task').
                                   including(:source_files, build: :pull_request).
                                   with_meta(
                                     event: 'pull_request',
                                     event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                     requested_at: be_timestamp
                                   )
    end
  end

  describe '#schedule' do
    let(:build){create(:build)}
    let(:task){create(:lint_task, :queued, :with_source_files, build: build)}
    subject(:scheduler){described_class.new(build)}

    it 'schedules the given task' do
      expect do
        scheduler.schedule(task)
      end.to change{LintTaskRequestedWorker.jobs.size}.by(1)

      job = LintTaskRequestedWorker.jobs.last
      expect(job['args'].first).to be_json_api_resource('lint_task').
                                   including(:source_files, build: :pull_request).
                                   with_meta(
                                     event: 'pull_request',
                                     event_id: 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
                                     requested_at: be_timestamp
                                   )
    end
  end
end
