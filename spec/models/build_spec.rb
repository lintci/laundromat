require 'rails_helper'

RSpec.describe Build, type: :model do
  describe '#valid?' do
    subject(:build){FactoryGirl.build(:build)}

    it 'requires an event' do
      build.event = nil
      expect(build).to_not be_valid
    end

    it 'requires an event id' do
      build.event_id = nil
      expect(build).to_not be_valid
    end

    it 'requires a payload' do
      build.payload = nil
      expect(build).to_not be_valid
    end

    it 'requires a repository' do
      build.repository = nil
      expect(build).to_not be_valid
    end
  end

  describe '#create_analyze_task' do
    let(:build){create(:build)}

    it 'creates the analysis task' do
      task = build.create_analyze_task

      expect(task.language).to eq('All')
      expect(task.tool).to eq('Linguist')
      expect(task).to be_a(AnalyzeTask)
    end
  end

  describe '#create_lint_task' do
    let(:build){create(:build)}
    let(:group){FactoryGirl.build(:source_file_group)}

    it 'creates an lint task' do
      task = build.create_lint_task(group)

      expect(task.language).to eq('Ruby')
      expect(task.tool).to eq('RuboCop')
      expect(task).to be_a(LintTask)
      expect(task.source_files.size).to eq(1)
    end
  end

  describe '#payload' do
    let(:build){FactoryGirl.build(:build)}

    it 'wraps the underlying JSON field with the Payload class' do
      expect(build.payload).to be_a(Payload)
    end
  end
end
