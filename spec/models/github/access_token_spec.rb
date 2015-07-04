require 'spec_helper'

describe Github::AccessToken do
  subject(:access_token){build(:github_access_token)}

  its(:access_token){is_expected.to eq('28cc8832046954d4343de2afff2c50edf0f67b38')}
  its(:scope){is_expected.to eq('repo,user')}
end
