require 'rails_helper'

RSpec.describe LintTask, type: :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:lint_task, :queued)}
    let(:running_task){build(:lint_task, :running)}
  end
end
