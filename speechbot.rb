require 'telegram/bot'
require 'logger'
require 'dotenv'

require_relative 'converter'
require_relative 'recognizer'

# Load env vars
Dotenv.load

token = ENV['BOT_TOKEN']

# Define Audio Struct
Struct.new("Audio", :voice, :raw, :rate, :encoding, :channels, :language)

Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started')
  bot.listen do |message|

    # return the audio id
    if message.voice
      # Download voice message
      file_path = bot.api.get_file(file_id: message.voice.file_id)["result"]["file_path"]
      require 'open-uri'
      voice = "/tmp/#{file_path}"
      raw = voice.gsub(/oga/, 'wav')
      open(voice, 'wb') do |file|
        file << open("https://api.telegram.org/file/bot#{token}/#{file_path}").read
      end
      
      # Create Audio Struct
      audio = Struct::Audio.new(voice, raw, 16000, :raw, 1, "it_IT")

      #Convert Audio
      Converter.convert(audio)
      text = Recognizer.recognize(audio)
      bot.api.send_message(chat_id: message.chat.id, text: text)
    end

    # return the audio id
    if message.document
      # Download audio file
      file_path = bot.api.get_file(file_id: message.document.file_id)["result"]["file_path"]
      require 'open-uri'
      voice = "/tmp/#{file_path}"
      raw = voice.gsub(/opus/, 'wav')
      open(voice, 'wb') do |file|
        file << open("https://api.telegram.org/file/bot#{token}/#{file_path}").read
      end
      
      # Create Audio Struct
      audio = Struct::Audio.new(voice, raw, 16000, :raw, 1, "it_IT")

      #Convert Audio
      Converter.convert(audio)
      text = Recognizer.recognize(audio)
      bot.api.send_message(chat_id: message.chat.id, text: text)
    end


    case message.text
    when /start/
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when /stop/
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
