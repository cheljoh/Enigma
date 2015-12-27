require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma'

def date
  Date.parse("2015-12-18")
end

class EnigmaTest < Minitest::Test

  def test_does_it_encrypt
    enigma = Enigma.new
    assert_equal "2yc69s2uz76uu",enigma.encrypt("hello ..end..", 15654, date)
  end

  def test_does_it_decrypt
    enigma = Enigma.new
    assert_equal "hello ..end..", enigma.decrypt("2yc69s2uz76uu", 15654, date)
  end

  def test_does_it_crack
    enigma = Enigma.new
    assert_equal "hello ..end..", enigma.crack("2yc69s2uz76uu")
  end

end
