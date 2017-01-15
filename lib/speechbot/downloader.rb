require 'dry-monads'
require 'open-uri'

module Downloader
  def self.download(bot, message)
    # Get link
    begin
      if message.voice
        file = bot.api.get_file(file_id: message.voice.file_id)['result']['file_path']
      else if message.document
        file = bot.api.get_file(file_id: message.document.file_id)['result']['file_path']
      end
    rescue Telegram::Bot::Exceptions::ResponseError
      # TODO Logging
      return Dry::Monads.Left('An error occurred trying to download your file, ' \
                              'please retry and if the problem persists ' \
                              'get in touch with us')
    end
    
    # Download
    input_path = "files/#{file}"
    open(input_path, 'wb') do |input|
      input << open("https://api.telegram.org/file/bot#{@token}/#{file}").read
    end
    return Dry::Monads.Right(input_path)
  end
end
