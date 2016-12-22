require 'telegram/bot'
require 'logger'
require 'dotenv'
require 'open-uri'
require 'dry-transaction'

require 'speechbot/container'

class SpeechBot
  # Load env vars
  Dotenv.load

  def initialize
    # Set bot token
    @token = ENV['BOT_TOKEN']
    @bot = Telegram::Bot::Client.new(@token, logger: Logger.new('requests.log'))
  end

  def download_file(message)
    file = @bot.api.get_file(file_id: message.voice.file_id)['result']['file_path']
    input_path = "/tmp/#{file}"
    open(input_path, 'wb') do |input|
      input << open("https://api.telegram.org/file/bot#{@token}/#{file}").read
    end
    return input_path
  end

  def recognize(message)
    input_path = download_file(message)
    # Initialize transaction
    convert_ogg = Dry.Transaction(container: Container) do
      step :convert
      step :recognize
    end 
    # Send reply
    convert_ogg.call(input_path, recognize: ["it_IT"]).value
  end

  def read_and_reply(message)
    # Catch voice messages or audio files
    if message.voice || message.document
      @bot.api.send_message(chat_id: message.chat.id, text: recognize(message))
    end

    case message.text
    when /start/
      @bot.api.send_message(chat_id: message.chat.id,
                            text: "Hello, #{message.from.first_name}")
    end
  end

  def update(data)
    json = JSON.parse(data)
    update = Telegram::Bot::Types::Update.new(json)
    message = update.message
    unless message.nil?
      read_and_reply(message)
    end
  end

end
