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
      let(:data){{'started_at' => started_at.stamp}}
      let(:started_at){Time.stamp_time}

      it 'transitions to running and sets the started_at time' do
        queued_task.start(data)

        expect(queued_task.status).to eq('running')
        expect(queued_task.started_at).to eq(started_at)
      end
    end
  end

  describe '#succeed' do
    context 'when status is running' do
      let(:data){{'finished_at' => finished_at.stamp, 'started_at' => started_at.stamp}}
      let(:finished_at){Time.stamp_time}
      let(:started_at){Time.stamp_time - 3.minutes}

      it 'transitions to success and sets the finished_at time' do
        running_task.succeed(data)

        expect(running_task.status).to eq('success')
        expect(running_task.finished_at).to eq(finished_at)
      end
    end
  end

  describe '#fail' do
    context 'when status is running' do
      let(:data){{'finished_at' => finished_at.stamp, 'started_at' => started_at.stamp}}
      let(:finished_at){Time.stamp_time}
      let(:started_at){Time.stamp_time - 3.minutes}

      it 'transitions to failed' do
        running_task.failure(data)

        expect(running_task.status).to eq('failed')
        expect(running_task.finished_at).to eq(finished_at)
      end
    end
  end
end
