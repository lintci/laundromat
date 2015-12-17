RSpec::Matchers.define :be_private_key do
  match do |actual|
    actual =~ /\A-----BEGIN RSA PRIVATE KEY-----.{1600,1700}-----END RSA PRIVATE KEY-----\n\z/m
  end
end
