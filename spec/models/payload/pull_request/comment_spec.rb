require 'spec_helper'

describe Payload::PullRequest::Comment do
  describe '#add' do
    let(:pull_request){build(:pull_request)}
    let(:source_file){build(:java_source_file, name: 'Good.java')}
    let(:violations){[build(:violation, line: 3, message: 'Nice comment.')]}
    subject(:comment){Payload::PullRequest::Comment.new(pull_request)}

    it 'successfully adds a comment to the pull request', vcr: {match_requests_on: [:method, :host, :path]} do
      result = comment.add(source_file, 3, violations)
      expect(result.path).to eq('Good.java')
      expect(result.body).to eq('Nice comment.')
      expect(result.position).to eq(3)
      expect(result.created_at).to be_a(Time)
    end
  end
end
