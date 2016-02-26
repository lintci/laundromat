require 'rspec/expectations'

RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    @actual, @expected = actual, expected.as_json.deep_stringify_keys

    expect(@actual).to eq(@expected)
  end

  failure_message do |actual|
    message = "expected that #{@actual} would match #{@expected}"
    message += "\nDiff:" + differ.diff(@actual, @expected)
    message
  end

  def differ
    RSpec::Support::Differ.new(
      :object_preparer => lambda { |object| RSpec::Matchers::Composable.surface_descriptions_in(object) },
      :color => RSpec::Matchers.configuration.color?
    )
  end
end
