require 'slack-notifier'

class Elevator < ApplicationRecord
    
    include ActiveModel::Dirty
    belongs_to :column
    before_update :slack_notify  

    
    def slack_notify
    
    puts "slack_notify"
    notifier = Slack::Notifier.new ENV["SLACK_TOKEN"]
    notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_was} to #{self.status}"

    end

end