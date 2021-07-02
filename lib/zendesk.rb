require 'zendesk_api'

client = ZendeskAPI::Client.new do |config|
  # Mandatory:

  config.url = "https://backofficecorpinc.zendesk.com/api/v2" # e.g. https://yoursubdomain.zendesk.com/api/v2

  # Basic / Token Authentication
  config.username = "transcript.jpg@gmail.com"

  # Choose one of the following depending on your authentication choice
  config.token = "YbjL4QwsElEcuCpvlQ67ulwPUmfTrYw5ZO9s0y9v"
  config.password = "Createcreatecreate256"

  # OAuth Authentication
  config.access_token = "d60f22594cb4b6dda48a211515d68dd37c9b41f6842cf3342414f31d0d264dcc"

  # Optional:

  # Retry uses middleware to notify the user
  # when hitting the rate limit, sleep automatically,
  # then retry the request.
  config.retry = true

  # Raise error when hitting the rate limit.
  # This is ignored and always set to false when `retry` is enabled.
  # Disabled by default.
  config.raise_error_when_rate_limited = false

  # Logger prints to STDERR by default, to e.g. print to stdout:
  require 'logger'
  config.logger = Logger.new(STDOUT)

  # Disable resource cache (this is enabled by default)
  config.use_resource_cache = false

  # Changes Faraday adapter
  # config.adapter = :patron

  # Merged with the default client options hash
  # config.client_options = {:ssl => {:verify => false}, :request => {:timeout => 30}}

  # When getting the error 'hostname does not match the server certificate'
  # use the API at https://yoursubdomain.zendesk.com/api/v2
end