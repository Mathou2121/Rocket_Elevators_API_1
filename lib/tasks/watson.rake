task :watson do

  require "active_record"
  require "ibm_watson"
  require "json"
  require "ibm_watson/authenticators"
  require "ibm_watson/text_to_speech_v1"
  include IBMWatson

  authenticator = Authenticators::IamAuthenticator.new(
      #keep the key like this for now until we know watson is working
      apikey: "R7FVOui8nSAdVMoHT-xOdWIVd_V-dFZYudK30uN4n0eg"
  )

  text_to_speech = TextToSpeechV1.new(
  authenticator: authenticator
  )
  text_to_speech.service_url = "https://api.us-east.text-to-speech.watson.cloud.ibm.com"

  voices = text_to_speech.list_voices
#  below prints the list of available voices  
#  puts JSON.pretty_generate(voices.result)

  ActiveRecord::Base.establish_connection(
    adapter:  "mysql2",
    host:     "localhost",
    username: "root",
    password: "c0nfess;ALWAYS",
    database: "Rocket_Elevators_Information_System_development"
  )

  amountElevators = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM elevators;")
  amountBuildings = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM buildings;")
  amountCustomers = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM customers;")
  amountQuotes    = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM quotes;")
  amountLeads     = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM leads;")
  amountBatteries = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM batteries;")
  amountCities    = ActiveRecord::Base.connection.execute("SELECT count( DISTINCT(city) ) FROM addresses;")

  theScript    = "Welcome, welcome to Rocket Elevators Dashboard. "
  theScript   += "There are currently #{amountElevators.first[0]} elevators deployed in the #{amountBuildings.first[0]} buildings of your #{amountCustomers.first[0]} customers. "
  theScript   += "Currently, #{amountElevators.first[0]} elevators are not in Running Status and are being serviced. "
  theScript   += "You currently have #{amountQuotes.first[0]} quotes awaiting processing. "
  theScript   += "You currently have #{amountLeads.first[0]} leads in your contact requests. "
  theScript   += "#{amountBatteries.first[0]} Batteries are deployed across #{amountCities.first[0]} cities"

  puts theScript

  # File.open("../../public/TTS.wav", "wb") do |audio_file|
  #   response = text_to_speech.synthesize(
  #     text: "Welcome, welcome to Rocket Elevators Dashboard.",
  #     accept: "audio/wav",
  #     voice: "en-US_AllisonVoice"
  #   ).result
  #   audio_file << response
  # end

end