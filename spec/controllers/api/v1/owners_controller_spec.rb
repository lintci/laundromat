require 'spec_helper'

describe API::V1::OwnersController do
  describe 'GET #index' do
    let(:owners){build_list(:owner, 1)}

    it_behaves_like('AuthenticatedRequest'){let(:request){get :index}}

    it 'responds with owners' do
      stub_auth

      expect(current_user).to receive(:owners).and_return(owners)

      get :index

      expect(json).to be_json_api_resource('owners')
    end
  end

  describe 'GET #show' do
    let(:owner){build(:owner)}

    it_behaves_like('AuthenticatedRequest'){let(:request){get :show, id: 1}}

    it 'responds with owner' do
      stub_auth

      expect(current_user).to receive_message_chain(:owners, :find).with('1').and_return(owner)

      get :show, id: 1

      expect(json).to be_json_api_resource('owner')
    end
  end
end
