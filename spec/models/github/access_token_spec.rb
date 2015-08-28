require 'spec_helper'

describe Github::AccessToken do
  subject(:access_token){build(:github_access_token)}

  it do
    is_expected.to have_attributes(
      access_token: '28cc8832046954d4343de2afff2c50edf0f67b38',
      scope: 'repo,user'
    )
  end
end
