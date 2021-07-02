require 'dropbox_api'

class Customer < ApplicationRecord
    has_many :buildings
    has_one :user

    after_create :dropbox_api
    after_update :dropbox_api

    def dropbox_api 
        Lead.all.each do |lead|
            if lead.email == self.company_contact_email || lead.email == self.technical_manager_email_for_service
                binary_file = lead.file.download
<<<<<<< HEAD
                client = DropboxApi::Client.new(ENV['DROPBOX_TOKEN'])
=======
                client = DropboxApi::Client.new(ENV["DROPBOX_TOKEN"])
>>>>>>> main
                client.create_folder("/#{lead.full_name}")
                client.upload "/#{lead.full_name}/attached_file", binary_file
                lead.file.destroy
                lead.file.blob.destroy
            end       
        end
    end
end
