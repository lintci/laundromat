require 'rails_helper'

RSpec.describe ClassifyTask, :type => :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:classify_task, :queued)}
    let(:running_task){build(:classify_task, :running)}
  end
end
