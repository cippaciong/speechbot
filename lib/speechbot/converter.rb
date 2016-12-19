require 'ruby-sox'
require 'dry-monads'

#audio = Struct::Audio.new(voice, raw, 16_000, :raw, 1, 'it_IT')
module Converter
  def self.convert(lossy)
    ext = lossy.split('.')[-1]
    raw = lossy.gsub(/#{ext}/, 'wav')
    sox = Sox::Cmd.new
                  .add_input(lossy)
                  .set_output(raw)
                  .set_effects(rate: 16_000, channels: 1)
    begin
      sox.run
    rescue Sox::Error
      return Dry::Monads.Left('Wrong input file encoding')
    end

    Dry::Monads.Right(raw)
  end
end
