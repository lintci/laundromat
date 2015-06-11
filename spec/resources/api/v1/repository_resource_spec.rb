require 'spec_helper'

describe API::V1::RepositoryResource, type: :resource do
  let(:model){build(:repository)}
  subject(:resource){described_class.new(model)}

  describe '#serialize_to_hash' do
    it 'generates the expected structure' do
      binding.pry
      expect(json(resource)).to match(
        data: {
          'id' => nil,
          'name' => 'guinea_pig',
          'owner' => 'lintci',
          'host' => 'Github',
          'status' => 'inactive',
          'slug' => 'gh/lintci/guinea_pig',
          'type' => 'repositories',
          :links => {
            self: '/api/v1/repositories/'
          }
        }
      )
    end
  end
end
