require 'rails_helper'

RSpec.describe Build, :type => :model do
  describe '#valid?' do
    subject(:build){FactoryGirl.build(:build)}

    it 'requires an event' do
      build.event = nil
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

  describe '#create_categorization_task' do
    let(:build){create(:build)}

    it 'creates the categorization task' do
      task = build.create_categorization_task

      expect(task.language).to eq('All')
      expect(task.linter).to eq('None')
      expect(task).to be_a(CategorizationTask)
    end
  end

  describe '#create_analysis_task' do
    let(:build){create(:build)}
    let(:file_modifications){{'ruby.rb' => [1, 2, 3, 7]}}

    it 'creates an analysis task' do
      expect_any_instance_of(AnalysisTask).to receive(:add_file_modifications).with(file_modifications)

      task = build.create_analysis_task('Ruby', 'Rubocop', file_modifications)

      expect(task.language).to eq('Ruby')
      expect(task.linter).to eq('Rubocop')
      expect(task).to be_a(AnalysisTask)
    end
  end

  describe '#payload' do
    let(:build){FactoryGirl.build(:build)}

    it 'wraps the underlying JSON field with the Payload class' do
      expect(build.payload).to be_a(Payload)
    end
  end
end
