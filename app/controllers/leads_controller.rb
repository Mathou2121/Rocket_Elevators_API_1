class LeadsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  before_action :set_lead, only: %i[ show edit update destroy ]
  after_action :sendEmail, only: :create
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
    # mail.add_content(Content.new(type: 'text/plain', value: "Greetings #{name}.
    # We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project #{project}.
    # A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
    # We’ll Talk soon
    # The Rocket Team"))
    mail.add_content(Content.new(type: 'text/html', value: "<html><body><p>Greetings #{name}.</p>
    <p>We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project #{project}.</p>
    <p>A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.</p>
    <p></p>
    <p>We’ll Talk soon</p>
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
