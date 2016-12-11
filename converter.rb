require "ruby-sox"

module Converter
  def Converter.convert(audio)
    sox = Sox::Cmd.new
                  .add_input(audio.voice)
                  .set_output(audio.raw)
                  .set_effects(:rate => audio.rate, :channels => audio.channels)
    sox.run
  end
end
