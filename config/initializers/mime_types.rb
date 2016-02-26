# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.unregister :json
Mime::Type.register "application/json", :json, %w(text/x-json application/jsonrequest application/vnd.api+json)

ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::Type.lookup('application/vnd.api+json')] = lambda do |body|
  binding.pry
  JSON.parse(body)
end
