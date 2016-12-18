lib = File.expand_path('../../lib/', __FILE__)  
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minitest/autorun'
require 'minitest/pride'
require 'speechbot/recognizer'

class RecognizerTest < Minitest::Test

  def setup
    @recognizer = Recognizer.new
  end

  #def test_ask_returns_an_answer
    #magic_ball = MagicBall.new
    #assert magic_ball.ask("Whatever") != nil
  #end

  #def test_predefined_answers_is_array
    #assert_kind_of Array, MagicBall::ANSWERS
  #end

  #def test_predefined_answers_is_not_empty
    #refute_empty MagicBall::ANSWERS
  #end
end
