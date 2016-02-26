require 'spec_helper'

describe API::V1::UsersController do
  describe 'GET #show' do
    it_behaves_like('AuthenticatedRequest'){let(:request){get :show}}

    it 'responds with user' do
      stub_auth

      get :show

      expect(json).to be_json_api_resource('user')
    end
  end
end
