require 'rails_helper'

RSpec.describe CategorizationTask, :type => :model do
  it_behaves_like 'Task' do
    let(:queued_task){build(:queued_categorization_task)}
    let(:running_task){build(:running_categorization_task)}
  end

end
