RSpec.shared_examples_for 'Task' do
  describe '#start' do
    context 'when status is queued' do
      it 'transitions to running' do
        queued_task.start

        expect(queued_task.status).to eq('running')
      end
    end
  end

  describe '#succeed' do
    context 'when status is running' do
      it 'transitions to success' do
        running_task.succeed

        expect(running_task.status).to eq('success')
      end
    end
  end

  describe '#fail' do
    context 'when status is running' do
      it 'transitions to failed' do
        running_task.fail

        expect(running_task.status).to eq('failed')
      end
    end
  end
end
