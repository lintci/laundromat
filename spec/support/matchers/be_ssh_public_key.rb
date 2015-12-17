RSpec::Matchers.define :be_ssh_public_key do
  match do |actual|
    actual =~ /\Assh-rsa [^\s]{372} .*\z/
  end
end
