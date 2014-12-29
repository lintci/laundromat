require 'spec_helper'

describe Payload do
  subject(:payload){build(:payload)}

  describe '#pull_request' do
    it 'returns a pull_request' do
      expect(payload.pull_request).to be_a(Payload::PullRequest)
    end
  end

  describe '#pull_request?' do
    it 'returns true if payload is for a pull request' do
      expect(payload).to be_pull_request
    end
  end

  describe 'full_name' do
    it 'returns the full name of repository' do
      expect(payload.full_name).to eq('lintci/guinea_pig')
    end
  end
end
