require 'spec_helper'

describe ActiveTasksQuery do
  describe '#find_each' do
    let!(:build){create(:build)}
    let!(:queued_task){create(:task, :queued, build: build)}
    let!(:scheduled_task){create(:task, :scheduled, build: build)}
    let!(:running_task){create(:task, :running, build: build)}
    let!(:success_task){create(:task, :success, build: build)}
    let!(:failed_task){create(:task, :failed, build: build)}

    context 'using build' do
      subject(:query){described_class.new(build)}

      it 'returns the total number of scheduled and running tasks' do
        expect(query.count).to eq(2)
      end
    end

    context 'using owner' do
      subject(:query){described_class.new(build.owner)}

      it 'returns the total number of scheduled and running tasks' do
        expect(query.count).to eq(2)
      end
    end
  end
end
