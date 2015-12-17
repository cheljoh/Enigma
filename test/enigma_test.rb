require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma'

class EnigmaTest < Minitest::Test

  def test_does_it_encrypt
    enigma = Enigma.new
    assert_equal "2yc69s2uz76uu",enigma.encrypt("hello ..end..", 15654, Date.today)
  end

  def test_does_it_decrypt
    enigma = Enigma.new
    assert_equal "hello ..end..", enigma.decrypt("2yc69s2uz76uu", 15654, Date.today)
  end

  def test_does_it_crack
    enigma = Enigma.new
    assert_equal "hello ..end..", enigma.crack("2yc69s2uz76uu")
  end

end
