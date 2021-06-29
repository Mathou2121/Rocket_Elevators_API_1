require "ibm_watson"
require "json"
require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

authenticator = Authenticators::IamAuthenticator.new(
    #keep the key like this for now until we know watson is working
    apikey: "wWOEFhLzOuvlDSrnXhebSIa6vpQmsfk7dcsX6nGKzHBw"
)

text_to_speech = TextToSpeechV1.new(
authenticator: authenticator
)
text_to_speech.service_url = "https://api.us-east.text-to-speech.watson.cloud.ibm.com"

voices = text_to_speech.list_voices
puts JSON.pretty_generate(voices.result)