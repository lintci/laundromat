require 'spec_helper'

describe Classification do
  subject(:classification){build(:classification)}

  its(:task_id){is_expected.to eq(1)}

  describe '#each_group' do
    it 'yields groups' do
      classification.each_group do |group|
        expect(group).to be_a(Classification::Group)
      end
    end
  end
end
