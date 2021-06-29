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

    from = SendGrid::Email.new(email: 'contact@rocketelevator.com')
    to = SendGrid::Email.new(email: '@lead.email')
    subject = 'Thanks you for contacting us!'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Greetings [@lead.full_name]
    We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project [@lead.project_name].
    A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
    We’ll Talk soon
    The Rocket Team')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['4f28587e99msh391b0dc918cacebp11f78ajsnfd671fad2478'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.parsed_body
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
