require 'telegram/bot'
require 'logger'
require 'dotenv'
require 'open-uri'

require 'speechbot/converter'
require 'speechbot/recognizer'

class SpeechBot
  # Load env vars
  Dotenv.load
  # Define Audio Struct
  Struct.new('Audio', :voice, :raw, :rate, :encoding, :channels, :language)

  def initialize
    # Set bot token
    @token = ENV['BOT_TOKEN']
    @bot = Telegram::Bot::Client.new(@token, logger: Logger.new('requests.log'))
  end

  def update(data)
    json = JSON.parse(data)
    update = Telegram::Bot::Types::Update.new(json)
    message = update.message
    unless message.nil?
      read_and_reply(message)
    end
  end

  # Define helper methods
  def prepare_reply(voice)
    # audio = Struct::Audio.new(voice, raw, 16_000, :raw, 1, 'it_IT')
    raw = convert(voice)
    recognize(raw)
  end

  def convert(audio)
    Converter.convert(audio).value
  end

  def recognize(audio)
    Recognizer.recognize(audio, "it_IT").value
  end

  def read_and_reply(message)
      # Catch voice messages or audio files
      if message.voice || message.document
        # catch voice messages
        if message.voice
          # Download voice message
          file_path = @bot.api.get_file(file_id: message.voice.file_id)['result']['file_path']
          voice = "/tmp/#{file_path}"
          raw = voice.gsub(/oga/, 'wav')
          open(voice, 'wb') do |file|
            file << open("https://api.telegram.org/file/bot#{@token}/#{file_path}").read
          end
          # Send reply
          text = prepare_reply(voice)
          @bot.api.send_message(chat_id: message.chat.id, text: text)
        end

        # Catch audio documents
        if message.document
          # Download audio file
          file_path = @bot.api.get_file(file_id: message.document.file_id)['result']['file_path']
          # Make sure is an opus file
          if file_path.include? 'opus'
            voice = "/tmp/#{file_path}"
            raw = voice.gsub(/opus/, 'wav')
            open(voice, 'wb') do |file|
              file << open("https://api.telegram.org/file/bot#{@token}/#{file_path}").read
            end
          # Send reply
          text = prepare_reply(voice)
          @bot.api.send_message(chat_id: message.chat.id, text: text)
          end
        end
      end

      case message.text
      when /start/
        @bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      end
  end
end
