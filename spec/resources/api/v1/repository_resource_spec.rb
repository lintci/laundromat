require 'spec_helper'

describe API::V1::RepositoryResource do
  let(:uuid){generate(:uuid)}
  let(:repository){build(:repository, id: uuid)}
  subject(:resource){described_class.new(repository)}

  describe '#as_json' do
    it 'generates the expected structure' do
      expect(resource.as_json).to eq(
        data: {
          'id' => uuid,
          'type' => 'repositories',
          'links' => {
            self: "/api/v1/repositories/#{uuid}"
          },
          'attributes' => {
            'name' => 'guinea_pig',
            'provider' => 'github',
            'status' => 'inactive'
          },
          'relationships' => {
            'owner' => {
              links: {
                self: "/api/v1/repositories/#{uuid}/relationships/owner",
                related: "/api/v1/repositories/#{uuid}/owner"
              }
            }
          }
        }
      )
    end
  end
end
