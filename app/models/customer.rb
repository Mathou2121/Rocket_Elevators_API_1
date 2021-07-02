require 'dropbox_api'

class Customer < ApplicationRecord
    has_many :buildings
    has_one :user

    after_commit :dropbox_api, on: :create


    def dropbox_api 
        Lead.all.each do |lead|
            if lead.email == self.company_contact_email || lead.email == self.technical_manager_email_for_service
                binary_file = lead.attached_file
                client = DropboxApi::Client.new("K4B7dPp-39kAAAAAAAAAAXZQaoSZFGn1uXjAOokUl39uftGvHtrtD2tmX7fnN5p1")
                client.add_folder
                client.upload '/', binary_file
                
            end       
        end
    end
end
