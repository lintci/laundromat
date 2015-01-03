require 'spec_helper'

describe Categorization do
  let(:finished_at){Time.iso8601('2014-12-10T00:54:46Z')}
  subject(:categorization){build(:categorization, finished_at: finished_at)}

  its(:task_id){is_expected.to eq(1)}
  its(:finished_at){is_expected.to eq(finished_at)}

  describe '#each_linter' do
    it 'yields linters' do
      categorization.each_linter do |linter|
        expect(linter).to be_a(Categorization::Linter)
      end
    end
  end
end
