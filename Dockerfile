FROM tutum.co/lintci/ruby:2.2.3
MAINTAINER LintCI

ENV SENTRY_DSN=CHANGEME \
    REDIS_URL=CHANGEME \
    NEW_RELIC_APP_NAME=Laundromat \
    NEW_RELIC_LICENCE_KEY=CHANGEME \
    LOGENTRIES_TOKEN=CHANGEME \
    SKYLIGHT_APPLICATION=CHANGEME \
    SKYLIGHT_AUTHENTICATION=CHANGEME \
    SERVICE_TEAM=LintCI \
    GITHUB_SERVICE_USER=luci-lint \
    GITHUB_SERVICE_PASSWORD=CHANGEME \
    GITHUB_SERVICE_TOKEN=CHANGEME \
    DATABASE_URL=CHANGEME \
    GITHUB_CLIENT_ID=CHANGEME \
    GITHUB_CLIENT_SECRET=CHANGEME \
    PUSHER_URL=CHANGEME \
    SSH_PASSPHRASE=CHANGEME \
    GITHUB_WEBHOOK_TOKEN=CHANGEME \
    PUSH_TO_START_URL=CHANGEME \
    PORT=8080 \
    WEB_CONCURRENCY=1 \
    MAX_THREADS=5 \
    RACK_ENV=production \
    RAILS_ENV=production \
    SECRET_KEY_BASE=CHANGEME


CMD puma -C config/puma.rb
