
require 'slack-ruby-client'

puts 'hello'

puts ENV["SLACK_API_TOKEN"]

Slack.configure do |config|
  config.token = Figaro.env.SLACK_API_TOKEN
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::Web::Client.new

client.auth_test

client.chat_postMessage(channel: '#elevator_operations', text: 'on RoR', as_user: true)