require 'speechbot/converter'
require 'speechbot/recognizer'
require 'dry-container'
require 'dry-transaction'
# Set up a container (using dry-container here)
class Container
  extend Dry::Container::Mixin

  register :convert, -> input {
    Converter.convert(input)
  }

  register :recognize, -> input, lang {
    Recognizer.recognize(input, lang)
  }
end
