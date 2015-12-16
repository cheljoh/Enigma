require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cracker'
# require 'simplecov'
# SimpleCov.start

class CrackTest < Minitest::Test

  def test_does_it_order_numbers_into_correct_position
    known_phrase = "nd.."
    output = "2yc69s2uz76uu"
    crack = Cracker.new
    cipher = Cipher.new
    last_four_unknown = cipher.characters_to_numbers(output[-4..-1])
    last_four_known = cipher.characters_to_numbers(known_phrase[-4..-1])
    known = crack.order_list(output, last_four_known)
    unknown = crack.order_list(output, last_four_unknown)
    assert_equal [37, 13, 3, 37], crack.order_list(output, last_four_known)
    assert_equal [20, 33, 32, 20], crack.order_list(output, last_four_unknown)
  end

  def test_does_it_calculate_key
    crack = Cracker.new
    output = "2yc69s2uz76uu"
    cipher = Cipher.new
    known_phrase = "nd.."
    last_four_unknown = cipher.characters_to_numbers(output[-4..-1])
    last_four_known = cipher.characters_to_numbers(known_phrase[-4..-1])
    known = crack.order_list(output, last_four_known)
    unknown = crack.order_list(output, last_four_unknown)
    crack.init_date_offsets
    base_key = crack.get_base_key(known, unknown)
    candidates = crack.key_candidates(base_key)
    assert_equal "15654", crack.test_keys(output, known_phrase, candidates)
  end

  def test_does_it_crack_the_code
    crack = Cracker.new(Time.now)
    assert_equal "hello ..end..", crack.crack("2yc69s2uz76uu")
  end

end
