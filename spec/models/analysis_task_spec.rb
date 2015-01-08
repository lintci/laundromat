require 'rails_helper'

RSpec.describe AnalysisTask, :type => :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:queued_analysis_task)}
    let(:running_task){build(:running_analysis_task)}
  end

  describe '#add_file_modifications' do
    let(:task){build(:analysis_task)}
    let(:linter){build(:linter)}

    it 'builds each of the associated records' do
      task.add_modified_files(linter)

      expect(task.modified_files.size).to eq(1)

      bad = task.modified_files.first

      expect(bad.attributes).to include('name' => 'bad.rb', 'lines' => [1, 2, 3])
    end
  end
end
