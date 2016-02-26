require 'spec_helper'

describe API::V1::RepositoriesController do
  describe 'GET #index' do
    let(:repositories){build_list(:repository, 1)}

    it_behaves_like('AuthenticatedRequest'){let(:request){get :index}}

    it 'responds with owners' do
      stub_auth

      expect(current_user).to receive(:repositories).and_return(repositories)

      get :index

      expect(json).to be_json_api_resource('repositories')
    end
  end

  describe 'GET #show' do
    let(:repository){build(:repository)}

    it_behaves_like('AuthenticatedRequest'){let(:request){get :show, id: 1}}

    it 'responds with repository' do
      stub_auth

      expect(current_user).to receive_message_chain(:repositories, :find).with('1').and_return(repository)

      get :show, id: 1

      expect(json).to be_json_api_resource('repository')
    end
  end
end
