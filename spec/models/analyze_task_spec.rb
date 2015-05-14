require 'rails_helper'

RSpec.describe AnalyzeTask, type: :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:analyze_task, :queued)}
    let(:scheduled_task){build(:analyze_task, :scheduled)}
    let(:running_task){build(:analyze_task, :running)}
  end
end
