require 'spec_helper'

describe API::V1::Auth::TokensController, type: :controller do
  describe 'POST #create' do
    let(:code){'1234'}
    let(:token){build(:access_token, id: 1)}

    context 'with valid parameters' do
      it 'responds successfully' do
        expect_any_instance_of(AuthenticateUser).to receive(:success){|&block| @block = block}
        expect_any_instance_of(AuthenticateUser).to receive(:call){@block.call(token)}

        post :create, code: '1234', provider: 'github'

        expect(response).to have_http_status(:success)
        expect(json).to match('access_token' => /\d+/, 'expires_in' => 2592000, 'user_id' => nil)
      end
    end

    context 'with invalid code' do
      it 'responds with unprocessable entity' do
        expect_any_instance_of(AuthenticateUser).to receive(:failure){|&block| @block = block}
        expect_any_instance_of(AuthenticateUser).to receive(:call) do
          user = token.user
          user.errors.add(:email, 'must be present')

          @block.call(user.errors)
        end

        post :create, code: '1234', provider: 'github'

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to match('errors' => {'email' => ['must be present']})
      end
    end
  end
end
