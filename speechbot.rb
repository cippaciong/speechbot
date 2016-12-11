require 'telegram/bot'
require 'logger'
require 'dotenv'
require 'open-uri'

require_relative 'converter'
require_relative 'recognizer'

# Load env vars
Dotenv.load

token = ENV['BOT_TOKEN']

# Define Audio Struct
Struct.new('Audio', :voice, :raw, :rate, :encoding, :channels, :language)

Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started')
  bot.listen do |message|
    # catch voice messages
    if message.voice || message.document
      if message.voice
        # Download voice message
        file_path = bot.api.get_file(file_id: message.voice.file_id)['result']['file_path']
        voice = "/tmp/#{file_path}"
        raw = voice.gsub(/oga/, 'wav')
        open(voice, 'wb') do |file|
          file << open("https://api.telegram.org/file/bot#{token}/#{file_path}").read
        end
      end

      # Catch audio documents
      if message.document
        # Download audio file
        file_path = bot.api.get_file(file_id: message.document.file_id)['result']['file_path']
        # Make sure is an opus file
        if file_path.include? 'opus'
          voice = "/tmp/#{file_path}"
          raw = voice.gsub(/opus/, 'wav')
          open(voice, 'wb') do |file|
            file << open("https://api.telegram.org/file/bot#{token}/#{file_path}").read
          end
        end
      end

      # Create Audio Struct
      audio = Struct::Audio.new(voice, raw, 16_000, :raw, 1, 'it_IT')

      # Convert Audio
      Converter.convert(audio)

      # Recognize audio
      text = Recognizer.recognize(audio)

      # Send reply
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
