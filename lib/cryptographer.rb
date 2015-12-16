require_relative 'cipher'
require_relative 'offsets'

class Cryptographer
  attr_reader :message, :date, :key, :a_message_array

  def initialize(key = rand.to_s[2..6], date = Time.now) #can pass random key or your own
    @message = message
    @key = key.to_s
    @date = date
    @a_letter_rotation = []
    @b_letter_rotation = []
    @c_letter_rotation = []
    @d_letter_rotation = []
    @a_encrypted_characters = []
    @b_encrypted_characters = []
    @c_encrypted_characters = []
    @d_encrypted_characters = []
  end

  def group_message_by_letter
    reset_message_arrays
    mapper = {0 => @a_message_array, 1 => @b_message_array, 2 => @c_message_array, 3 => @d_message_array}
    @character_list.each_index do |index|
        mapper[index % 4] << @character_list[index]
    end
  end

  def reset_message_arrays
    @a_message_array = []
    @b_message_array = []
    @c_message_array = []
    @d_message_array = []
  end

  def encrypt(message)
    cipher = Cipher.new
    @character_list = cipher.characters_to_numbers(message.strip)
    group_message_by_letter
    get_final_rotation(1)
    use_cipher_on_final_rotation
    encrypted_message.join
  end

  def decrypt(output)
    cipher = Cipher.new
    @character_list = cipher.characters_to_numbers(output) #strip output maybe
    group_message_by_letter
    get_final_rotation(-1)
    use_cipher_on_final_rotation
    encrypted_message.join
  end

  def get_final_rotation(scale) #add name values and values from date and key
    offsets = Offsets.new(@key, @date, scale)
    @a_letter_rotation = rotation_calculation(@a_message_array, offsets.a_key_rotation, offsets.a_offset)
    @b_letter_rotation = rotation_calculation(@b_message_array, offsets.b_key_rotation, offsets.b_offset)
    @c_letter_rotation = rotation_calculation(@c_message_array, offsets.c_key_rotation, offsets.c_offset)
    @d_letter_rotation = rotation_calculation(@d_message_array, offsets.d_key_rotation, offsets.d_offset)
  end

  def rotation_calculation(array, rotation, offset)
      array.map do |value|
      value + rotation + offset
      end
  end

  def use_cipher_on_final_rotation #a is 28, 35, need to modulo 38
    @a_encrypted_characters = map_encrypted_characters(@a_letter_rotation)
    @b_encrypted_characters = map_encrypted_characters(@b_letter_rotation)
    @c_encrypted_characters = map_encrypted_characters(@c_letter_rotation)
    @d_encrypted_characters = map_encrypted_characters(@d_letter_rotation)
  end

  def map_encrypted_characters(letter_rotation)
    cipher = Cipher.new
    cipher.numbers_to_characters(letter_rotation)
  end

  def encrypted_message #order elements into correct order
    encrypted_messages_separate = [@a_encrypted_characters, @b_encrypted_characters, @c_encrypted_characters, @d_encrypted_characters]
    interleave(encrypted_messages_separate)
  end

  def interleave(encrypted_messages_separate)
    encrypted_message = []
    count = @a_encrypted_characters.count + 1 #B, C, and D arrays will always be less than or equal to A array
    count.times do |index|
      encrypted_messages_separate.each do |element|
        encrypted_message << element[index] if index < element.length
      end
    end
    encrypted_message
  end

end

# message = Cryptographer.new(15654, Time.now) #make encrypt method, calls all these methods below
# encrypted = message.encrypt("hello")
# decrypted = message.decrypt(encrypted)
#
# puts encrypted
# puts decrypted

# enigma = Cryptographer.new
# enigma.crack("2yc69s2uz76uu")
