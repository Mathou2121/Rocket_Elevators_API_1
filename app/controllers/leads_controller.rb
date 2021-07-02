class LeadsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  before_action :set_lead, only: %i[ show edit update destroy ]
  after_action :sendEmail, only: :create
  after_action :makeTicket, only: :create
  # GET /leads or /leads.json
  def index
    @leads = Lead.all
  end

  # GET /leads/1 or /leads/1.json
  def show
  end
  

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads or /leads.json
  def create
    @lead = Lead.new(lead_params)


    respond_to do |format|
      if @lead.save
        format.html { redirect_to @lead, notice: "Lead was successfully created." }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  def makeTicket
    puts "*********** CREATING ZENDESK TICKET ***************"
    require 'zendesk_api'
    client = ZendeskAPI::Client.new do |config|
      # Mandatory:
    
      config.url = "https://rocketelevator4998.zendesk.com/api/v2" # e.g. https://yoursubdomain.zendesk.com/api/v2
    
      # Basic / Token Authentication
      config.username = ENV["ZENDESK USERNAME"]
    
      # Choose one of the following depending on your authentication choice
      config.token = ENV["ZENDESK APIKEY"]
      config.password = ENV["ZENDESK PASSWORD"]
    
      # OAuth Authentication
      config.access_token = ENV["ZENDESK OATH"]
    
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
    ZendeskAPI::Ticket.create!(client, :subject => :project_name, :comment => { :value => :project_description }, :submitter_id => @lead.id, :priority => "urgent") 
  end

  def sendEmail


    puts "*********** SENDING SENDGRID EMAIL ***************"
    
    name = @lead.full_name
    project = @lead.project_name
    mail = SendGrid::Mail.new
    mail.from = Email.new(email: 'anthony_rosby@hotmail.com')
    mail.subject = 'Thanks you for contacting us!'

    personalization = Personalization.new
    personalization.add_to(Email.new(email: @lead.email, name: @lead.full_name))
    personalization.subject = 'Thanks you for contacting us!'
    mail.add_personalization(personalization)
    mail.add_content(Content.new(type: 'text/html', value: "<html><body><p>Greetings #{name},</p>
    <p>We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project #{project}.</p>
    <p>A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.</p>
    <p></p>
    <p>We’ll talk soon,</p>
    <p>The Rocket Team</p> <img src=\"https://drive.google.com/uc?id=1axgcU1YqgMQPd3w-99vuBxvDrUoDxX-t\" style=\"width:300px;height:100px;\"></body></html>"))


    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
    
  end

  # PATCH/PUT /leads/1 or /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: "Lead was successfully updated." }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1 or /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: "Lead was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lead_params
      params.require(:lead).permit(:full_name, :company_name, :email, :phone, :project_name, :project_description, :dept_in_charge_of_elevators, :message, :date_of_contact_request, :file)
    end
end
