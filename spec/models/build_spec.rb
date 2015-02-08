require 'rails_helper'

RSpec.describe Build, :type => :model do
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

  describe '#create_classify_task' do
    let(:build){create(:build)}

    it 'creates the classification task' do
      task = build.create_classify_task

      expect(task.language).to eq('All')
      expect(task.tool).to eq('Linguist')
      expect(task).to be_a(ClassifyTask)
    end
  end

  describe '#create_lint_task' do
    let(:build){create(:build)}
    let(:linter){FactoryGirl.build(:linter)}

    it 'creates an lint task' do
      expect_any_instance_of(LintTask).to receive(:add_modified_files).with(linter)

      task = build.create_lint_task(linter)

      expect(task.language).to eq('Ruby')
      expect(task.tool).to eq('Rubocop')
      expect(task).to be_a(LintTask)
    end
  end

  describe '#payload' do
    let(:build){FactoryGirl.build(:build)}

    it 'wraps the underlying JSON field with the Payload class' do
      expect(build.payload).to be_a(Payload)
    end
  end
end
