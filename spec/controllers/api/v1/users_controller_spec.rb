require 'spec_helper'

describe API::V1::UsersController do
  describe 'GET #show' do
    let(:access_token){create(:access_token)}
    let(:user){access_token.user}

    it_behaves_like('AuthenticatedRequest'){let(:request){get :show, id: 1}}

    it 'responds with user' do
      mock_access_token_for(user)

      get :show, id: user.id

      expect(json).to match_json(API::V1::UserSerializer.new(user))
    end
  end
end
