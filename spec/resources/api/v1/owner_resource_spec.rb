require 'spec_helper'

describe API::V1::OwnerResource do
  let(:owner){build(:owner, id: 1)}
  subject(:resource){described_class.new(owner)}

  describe '#as_json' do
    it 'generates the expected structure' do
      expect(resource.as_json).to eq(
        data: {
          'id' => '1',
          'type' => 'owners',
          'links' => {
            self: '/api/v1/owners/1'
          },
          'attributes' => {
            'name' => 'lintci',
            'provider' => 'github'
          },
          'relationships' => {
            'repositories' => {
              links: {
                self: '/api/v1/owners/1/relationships/repositories',
                related: '/api/v1/owners/1/repositories'
              }
            }
          }
        }
      )
    end
  end
end
