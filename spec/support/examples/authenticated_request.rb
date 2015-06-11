RSpec.shared_examples_for 'AuthenticatedRequest' do
  it 'requires authentication' do
    request

    expect(response).to have_http_status(:unauthorized)
    expect(response.headers['WWW-Authenticate']).to eq('Bearer realm="Application"')
  end
end
