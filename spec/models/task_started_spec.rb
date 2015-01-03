require 'spec_helper'

describe TaskStarted do
  subject(:event){build(:task_started, task_id: task_id, started_at: started_at)}
  let(:task_id){1}
  let(:started_at){iso8601_time(Time.now)}

  its(:task_id){is_expected.to eq(task_id)}
  its(:started_at){is_expected.to eq(started_at)}
end
