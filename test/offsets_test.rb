gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/offsets'

class OffsetsTest < Minitest::Test

  def test_does_date_calculation_produce_4_numbers
    offsets = Offsets.new(15643, Time.now, 1)
    assert_equal 4, offsets.date_calculation.length
  end

  def test_d_date_offset
    offsets = Offsets.new(15643, Time.now, 1)
    assert_equal 5, offsets.d_offset
  end

  def test_d_key_rotation
    offsets = Offsets.new(15643, Time.now, 1)
    assert_equal 43, offsets.d_key_rotation
  end

end
