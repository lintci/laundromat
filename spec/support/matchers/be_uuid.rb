RSpec::Matchers.define :be_uuid do
  match do |actual|
    actual =~ /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/
  end
end
