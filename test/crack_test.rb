gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
#require '../lib/crack'

class CrackTest < Minitest::Test

  def test_does_it_crack_the_code
    skip
    crack = Crack.new("2yc69s2uz76uu", Date.today)
    assert_equal "hello ..end..", crack.crack
  end

end
