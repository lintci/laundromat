require 'rspec/expectations'

RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    actual == expected.as_json.deep_stringify_keys
  end

  failure_message do |actual|
    "expected that #{actual.to_json} would eq #{expected.to_json}"
  end
end
