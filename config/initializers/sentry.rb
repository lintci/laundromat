if Rails.env.production?
  require 'raven'

  Raven.configure do |config|
    config.dsn = Rails.application.secrets.sentry_dsn
  end
end
