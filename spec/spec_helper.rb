ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'Services', 'app/services'
  add_group 'Workers', 'app/workers'
  add_group 'Serializers', 'app/serializers'
  add_group 'Queries', 'app/queries'

  coverage_dir ENV['CIRCLE_ARTIFACTS'] if ENV['CIRCLE_ARTIFACTS']
end

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'vcr'
require 'sidekiq/testing'
require 'stamped/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each{|f| require f}

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/vcr_cassettes', __FILE__)
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<CREDENTIALS>'){"#{ENV['GITHUB_SERVICE_USER']}:#{ENV['GITHUB_SERVICE_PASSWORD']}"}
  config.filter_sensitive_data('<GITHUB_OAUTH_TOKEN>'){ENV['GITHUB_OAUTH_TOKEN']}
  config.filter_sensitive_data('<GITHUB_SERVICE_TOKEN>'){ENV['GITHUB_SERVICE_TOKEN']}
  config.filter_sensitive_data('<GITHUB_CLIENT_ID>'){ENV['GITHUB_CLIENT_ID']}
  config.filter_sensitive_data('<GITHUB_CLIENT_SECRET>'){ENV['GITHUB_CLIENT_SECRET']}
  config.filter_sensitive_data('<GITHUB_WEBHOOK_TOKEN>'){ENV['GITHUB_WEBHOOK_TOKEN']}
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
  config.include FixtureFile
  config.include FactoryGirl::Syntax::Methods
  config.include Helpers::Controllers, type: :controller
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = './spec/examples.txt'

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end

  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    Sidekiq::Worker.clear_all
  end
end
