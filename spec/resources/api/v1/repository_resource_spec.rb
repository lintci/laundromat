require 'spec_helper'

describe API::V1::RepositoryResource do
  let(:repository){build(:repository, id: 1)}
  subject(:resource){described_class.new(repository)}

  describe '#as_json' do
    it 'generates the expected structure' do
      expect(resource.as_json).to eq(
        data: {
          'id' => '1',
          'type' => 'repositories',
          'links' => {
            self: '/api/v1/repositories/1'
          },
          'attributes' => {
            'name' => 'guinea_pig',
            'provider' => 'github',
            'status' => 'inactive'
          },
          'relationships' => {
            'owner' => {
              links: {
                self: '/api/v1/repositories/1/relationships/owner',
                related: '/api/v1/repositories/1/owner'
              }
            }
          }
        }
      )
    end
  end
end
