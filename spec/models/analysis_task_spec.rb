require 'rails_helper'

RSpec.describe AnalysisTask, :type => :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:queued_analysis_task)}
    let(:running_task){build(:running_analysis_task)}
  end

  describe '#add_file_modifications' do
    let(:task){build(:analysis_task)}
    let(:file_modifications) do
      {
        'good.rb' => [1, 2, 7],
        'bad.rb' => [3, 5]
      }
    end

    it 'builds each of the associated records' do
      task.add_file_modifications(file_modifications)

      expect(task.modified_files.size).to eq(2)

      good, bad = task.modified_files

      expect(good.attributes).to include('name' => 'good.rb', 'lines' => [1, 2, 7])
      expect(bad.attributes).to include('name' => 'bad.rb', 'lines' => [3, 5])
    end
  end
end
