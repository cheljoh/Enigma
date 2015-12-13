gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/cryptographer'

class Cryptographer_Test < Minitest::Test

  def test_does_it_create_a_key_of_five_numbers
    date = Cryptographer.new
    assert_equal 5, date.key.length
  end

  def test_can_you_pass_in_own_key
    encrypt = Cryptographer.new(15436)
    assert_equal "15436", encrypt.key
  end

  def test_add_d_offset_rotation_and_letter_value
    encrypt = Cryptographer.new(15654)
    encrypt.encrypt("hello")
    assert_equal [70], encrypt.get_final_rotation(1)
  end

  def test_does_it_group_numbers_by_letter
    message = Cryptographer.new(15654)
    message.encrypt("hello")
    assert_equal [7, 14], message.a_message_array #just a_message_array
  end

  def test_does_it_calculate_final_rotation
    message = Cryptographer.new(15654)
    message.encrypt("hello")
    assert_equal [70], message.get_final_rotation(1) #for just d_letter_rotation
  end

  def test_use_cipher_on_final_rotation #will return encrypted d array
    message = Cryptographer.new(15654)
    message.encrypt("hello")
    assert_equal ["6"], message.use_cipher_on_final_rotation
  end

  def test_does_it_order_arrays_into_correct_order
    message = Cryptographer.new(15654)
    message.encrypt("hello")
    assert_equal ["2", "y", "c", "6", "9"], message.encrypted_message
  end

  def test_will_it_encrypt_a_message
    message = Cryptographer.new(15654)
    assert_equal "2yc69", message.encrypt("hello")
  end

  def test_will_it_decrypt_a_message
    message = Cryptographer.new(15654)
    assert_equal "hello", message.decrypt("2yc69")
  end

end
