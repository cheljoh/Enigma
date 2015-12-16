gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
#require '../lib/cracker'

class CrackTest < Minitest::Test

  def test_does_it_order_numbers_into_correct_position
    skip
    crack = Cracker.new("2yc69s2uz76uu")
    cipher = Cipher.new
    character_list = cipher.characters_to_numbers(output.strip)
    last_four_unknown = character_list[-4..-1] #what are the letters
    last_four_known = [13, 3, 37, 37]
    order_list(character_list, last_four_known, last_four_unknown)
    assert_equal [37, 13, 3, 37], crack.known
    assert_equal [20, 33, 32, 20], crack.unknown
  end

  def test_does_it_calculate_key
    skip
    crack = Cracker.new("2yc69s2uz76uu")
    cipher = Cipher.new
    character_list = cipher.characters_to_numbers(output.strip)
    last_four_unknown = character_list[-4..-1] #what are the letters
    last_four_known = [13, 3, 37, 37]
    order_list(character_list, last_four_known, last_four_unknown)
    date_calculation
    init_date_offsets
    key_calculation
    assert_equal 15654, crack.key
  end

  def test_does_it_crack_the_code
    skip
    crack = Cracker.new("2yc69s2uz76uu", Time.now)
    assert_equal "hello ..end..", crack.crack
  end

end
