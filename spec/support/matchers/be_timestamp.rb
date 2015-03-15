RSpec::Matchers.define :be_timestamp do
  match do |actual|
    @expected = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z\z/
    actual =~ @expected
  end

  diffable
end
