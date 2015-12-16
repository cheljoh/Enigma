gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cipher'
require 'simplecov'
SimpleCov.start

class CipherTest < Minitest::Test

  def test_turn_message_into_numbers
    cipher = Cipher.new
    assert_equal [7, 4, 11, 11, 14], cipher.characters_to_numbers("hello")
  end

  def test_turn_character_into_number
    cipher = Cipher.new
    assert_equal 4, cipher.character_to_number("e")
  end

  def test_turn_numbers_into_characters
    cipher = Cipher.new
    assert_equal ["2", "y", "c", "6", "9"], cipher.numbers_to_characters([28, 62, 78, 70, 35])
  end

  def test_turn_number_into_character
    cipher = Cipher.new
    assert_equal " ", cipher.number_to_character(36)
  end

end
