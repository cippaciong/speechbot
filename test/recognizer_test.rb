require_relative 'test_helper'
require 'speechbot/recognizer'

class RecognizerTest < Minitest::Test

  def test_invalid_encoding
    assert_equal 'Wrong input file encoding',
      Recognizer.recognize('test/samples/not_ogg', 'it_IT').value
  end

  def test_valid_file
    assert_equal 'Vanna storna',
      Recognizer.recognize('test/samples/audio.wav', 'it_IT').value
  end
  def test_file_too_long
    assert_equal 'Files longer than 1 minute are not supported for now, sorry :(',
      Recognizer.recognize('test/samples/audio_too_long.wav', 'it_IT').value
  end
end
