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
      let(:event){double(started_at: started_at)}

      it 'transitions to running' do
        queued_task.start(event)

        expect(queued_task.status).to eq('running')
      end

      it 'sets the started_at time' do
        queued_task.start(event)

        expect(queued_task.started_at).to eq(started_at)
      end
    end
  end

  describe '#succeed' do
    context 'when status is running' do
      let(:finished_at){Time.now}
      let(:event){double(finished_at: finished_at)}

      it 'transitions to success' do
        running_task.succeed(event)

        expect(running_task.status).to eq('success')
      end

      it 'sets the finished_at time' do
        running_task.succeed(event)

        expect(running_task.finished_at).to eq(finished_at)
      end
    end
  end

  describe '#fail' do
    context 'when status is running' do
      let(:finished_at){Time.now}
      let(:event){double(finished_at: finished_at)}

      it 'transitions to failed' do
        running_task.fail(event)

        expect(running_task.status).to eq('failed')
      end

      it 'sets the finished_at time' do
        running_task.succeed(event)

        expect(running_task.finished_at).to eq(finished_at)
      end
    end
  end
end
