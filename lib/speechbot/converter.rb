require 'ruby-sox'

module Converter
  def self.convert(audio)
    if self.opus?(audio)
      sox = Sox::Cmd.new
                    .add_input(audio.voice)
                    .set_output(audio.raw)
                    .set_effects(rate: audio.rate, channels: audio.channels)
      sox.run
    else
      'Sorry, only Opus (ogg) files are supported'
    end
  end

  private
  def self.opus?(audio)
    # Suppress stderr messages
    $stderr.reopen("/dev/null", "w")

    # Run sox --i and checks if output contains 'Opus'
    IO.popen(['sox', '--i', audio], 'r') do |f|
      return !f.gets(nil).to_s.scan('Opus').empty?
    end
  end

end
