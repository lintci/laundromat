require 'spec_helper'

describe API::V1::ActivationsController do
  describe 'POST #create' do
    let(:activation_json) do
      {
        data: {
          type: 'activations',
          relationships: {
            repository: {
              data: {
                id: 'de305d54-75b4-431b-adb2-eb6b9e546014',
                type: 'repositories'
              }
            }
          }
        }
      }
    end

    it_behaves_like('AuthenticatedRequest'){let(:request){post :create}}

    it 'starts activation and responds with accepted' do
      stub_auth

      expect(StartActivatingRepository).to receive(:call).with(current_user, {:repository_id=>"de305d54-75b4-431b-adb2-eb6b9e546014"})

      post :create, activation_json

      expect(response).to be_accepted
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like('AuthenticatedRequest'){let(:request){delete :destroy, id: '1'}}

    it 'starts deactivation and responds with accepted' do
      stub_auth

      expect(StartDeactivatingRepository).to receive(:call).with(current_user, 'de305d54-75b4-431b-adb2-eb6b9e546014')

      delete :destroy, id: 'de305d54-75b4-431b-adb2-eb6b9e546014'

      expect(response).to be_accepted
    end
  end
end
