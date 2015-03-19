require 'rails_helper'

RSpec.describe LintTask, :type => :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:lint_task, :queued)}
    let(:running_task){build(:lint_task, :running)}
  end

  describe '#add_file_modifications' do
    let(:task){build(:lint_task)}
    let(:group){build(:group)}

    it 'builds each of the associated records' do
      task.add_modified_files(group)

      expect(task.modified_files.size).to eq(1)

      bad = task.modified_files.first

      expect(bad.attributes).to include('name' => 'bad.rb', 'lines' => [1, 2, 3, 4])
    end
  end
end
