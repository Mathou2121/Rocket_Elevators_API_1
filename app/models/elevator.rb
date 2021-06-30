require 'slack-notifier'

class Elevator < ApplicationRecord
    include ActiveModel::Dirty
    belongs_to :column
    before_update :slack_notify  

    
    
    
    def slack_notify
    
    puts "slack_notify"
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_was} to #{self.status}"

    end
end