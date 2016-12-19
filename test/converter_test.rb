lib = File.expand_path('../../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minitest/autorun'
require 'minitest/pride'
require 'speechbot/converter'

class ConverterTest < Minitest::Test

  def test_truth
    assert true
  end

  def test_empty_file
    assert_equal 'Wrong input file encoding',
      Converter.convert('/tmp/not_ogg').value
  end

  def test_valid_file
    assert_equal '/tmp/audio.wav',
      Converter.convert('/tmp/audio.ogg').value
  end

  #def test_predefined_answers_is_not_empty
    #refute_empty MagicBall::ANSWERS
  #end
end
