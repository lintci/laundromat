RSpec.shared_examples_for 'Task' do
  describe '#valid?' do
    subject(:task){queued_task}

    it 'expects a build' do
      task.build = nil
      expect(task).to_not be_valid
    end

    it 'expects a status' do
      task.status = nil
      expect(task).to_not be_valid
    end

    it 'expects a type' do
      task.type = nil
      expect(task).to_not be_valid
    end
  end

  describe '#start' do
    context 'when status is queued' do
      let(:started_at){Time.now}

      it 'transitions to running and sets the started_at time' do
        queued_task.start(started_at)

        expect(queued_task.status).to eq('running')
        expect(queued_task.started_at).to eq(started_at)
      end
    end
  end

  describe '#succeed' do
    context 'when status is running' do
      let(:finished_at){Time.now}

      it 'transitions to success and sets the finished_at time' do
        running_task.succeed(finished_at)

        expect(running_task.status).to eq('success')
        expect(running_task.finished_at).to eq(finished_at)
      end
    end
  end

  describe '#fail' do
    context 'when status is running' do
      let(:finished_at){Time.now}

      it 'transitions to failed' do
        running_task.fail(finished_at)

        expect(running_task.status).to eq('failed')
        expect(running_task.finished_at).to eq(finished_at)
      end
    end
  end
end
