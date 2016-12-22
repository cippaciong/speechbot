require_relative 'test_helper'
require 'speechbot/converter'

class ConverterTest < Minitest::Test

  def test_empty_file
    assert_equal 'Wrong input file encoding',
      Converter.convert('test/samples/not_ogg').value
  end

  def test_valid_file
    assert_equal 'test/samples/audio.wav',
      Converter.convert('test/samples/audio.ogg').value
  end
  def test_long_file
    assert_equal 'test/samples/audio_too_long.wav',
      Converter.convert('test/samples/audio_too_long.ogg').value
  end
end
