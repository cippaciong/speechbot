require 'minitest/autorun'
require 'minitest/pride'
require 'speechbot/converter'

class ConverterTest < Minitest::Test

  def test_convert
    assert_equal "Sorry, only Opus (ogg) files are supported",
      Converter.convert('/tmp/not_ogg')
  end

  #def test_predefined_answers_is_not_empty
    #refute_empty MagicBall::ANSWERS
  #end
end
