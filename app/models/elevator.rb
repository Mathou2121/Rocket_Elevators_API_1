require 'slack-notifier'

class Elevator < ApplicationRecord
    
    include ActiveModel::Dirty
    belongs_to :column
    before_update :slack_notify
    before_update :sms_technical_contact 
    
    def slack_notify
        
        puts "slack_notify"
        notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
        notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_was} to #{self.status}"
        
    end
    def sms_technical_contact
        if self.status == "intervention"
            account_sid = ENV['TWILIO_ACCOUNT_SID']
            auth_token = ENV['TWILIO_AUTH_TOKEN']
            @client = Twilio::REST::Client.new(account_sid, auth_token)
            
            from = '+15415834581'
            to = '+12048906332'
            @client.messages.create(
                from: from, 
                to: to,
                body: "Rocket Elevators Alert! Elevator #{self.serial_number} has a status of Intervention. Please intervene as soon as possible.")
        end 
    end
end