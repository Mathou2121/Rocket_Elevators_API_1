class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  after_action :makeTicket, only: :create

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
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
    ZendeskAPI::Ticket.create!(client, :subject => :company_name, :comment => { :value => :final_price }, :submitter_id => @quote.id, :priority => "urgent") 
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:building_type, :product_line, :apartments, :floors, :basements, :elevators, :companies, :parking_spots, :max_occupancy_per_floor, :corporations, :business_hours, :elevator_amount, :unit_price, :total_price, :install_fees, :final_price, :company_name, :email)
    end
end
