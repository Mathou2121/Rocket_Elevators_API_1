class LeadsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  before_action :set_lead, only: %i[ show edit update destroy ]
  after_action :sendEmail
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

    # from = SendGrid::Email.new(email: 'anthony_rosby@hotmail.com')
    # to = SendGrid::Email.new(email: 'anthony_rosby@hotmail.com')
    # subject = 'Thanks you for contacting us!'
    # content = SendGrid::Content.new(type: 'text/plain', value: 'Greetings [@lead.full_name]
    # We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project [@lead.project_name].
    # A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
    # We’ll Talk soon
    # The Rocket Team')
    # mail = SendGrid::Mail.new(from, subject, to, content)

    # sg = SendGrid::API.new(api_key: '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')
    # response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.body
    # puts response.parsed_body
    # puts response.headers

    
    mail = SendGrid::Mail.new
    mail.from = Email.new(email: 'anthony_rosby@hotmail.com')
    mail.subject = 'Thanks you for contacting us!'

    personalization = Personalization.new
    personalization.add_to(Email.new(email: 'anthony_rosby@hotmail.com', name: 'antho'))
    personalization.subject = 'Thanks you for contacting us!'
    mail.add_personalization(personalization)

    mail.add_content(Content.new(type: 'text/plain', value: 'Greetings [@lead.full_name]
    We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project [@lead.project_name].
    A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
    We’ll Talk soon
    The Rocket Team'))

    sg = SendGrid::API.new(api_key: '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')
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
