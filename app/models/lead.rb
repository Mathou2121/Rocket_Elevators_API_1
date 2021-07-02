class Lead < ApplicationRecord   
    ZendeskAPI::Ticket.create!(client, :subject => "Test Ticket", :comment => { :value => "This is a test" }, :submitter_id => client.current_user.id, :priority => "urgent") 
    has_one_attached :file
end


