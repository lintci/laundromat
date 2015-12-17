require 'spec_helper'

describe API::V1::OwnerResource do
  let(:uuid){generate(:uuid)}
  let(:owner){build(:owner, id: uuid)}
  subject(:resource){described_class.new(owner)}

  describe '#as_json' do
    it 'generates the expected structure' do
      expect(resource.as_json).to eq(
        data: {
          'id' => uuid,
          'type' => 'owners',
          'links' => {
            self: "/api/v1/owners/#{uuid}"
          },
          'attributes' => {
            'name' => 'lintci',
            'provider' => 'github'
          },
          'relationships' => {
            'repositories' => {
              links: {
                self: "/api/v1/owners/#{uuid}/relationships/repositories",
                related: "/api/v1/owners/#{uuid}/repositories"
              }
            }
          }
        }
      )
    end
  end
end
