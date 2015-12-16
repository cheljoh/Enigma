require_relative 'cryptographer'
require_relative 'cipher'

class Cracker

  attr_reader :rotations, :key, :known, :unknown

  def initialize (date = Time.now)
    @date = date
  end

  #cant you use key and then do decrypt class?????


  def crack(output)
    cipher = Cipher.new
    character_list = cipher.characters_to_numbers(output.strip)
    last_four_unknown = character_list[-4..-1] #what are the letters
    last_four_known = [13, 3, 37, 37]
    order_list(character_list, last_four_known, last_four_unknown)
    date_calculation
    init_date_offsets
    key_calculation
    decrypt_message_using_key(output)
  end

  def decrypt_message_using_key(output)
    crack_message = Cryptographer.new(@key)
    crack_message.decrypt(output.strip)
  end

  def order_list(character_list, last_four_known, last_four_unknown) #use rotation
    if character_list.length % 4 == 0
      @known = last_four_known
      @unknown =last_four_unknown
    elsif character_list.length % 4 == 1
      @known = last_four_known.rotate
      @unknown =last_four_unknown.rotate
    elsif character_list.length % 4 == 2
      @known = last_four_known.rotate(2)
      @unknown = last_four_unknown.rotate(2)
    elsif character_list.length % 4 == 3
      @known = new_array = last_four_known.rotate(3)
      @unknown = last_four_unknown.rotate(3)
    end
  end

  def date_calculation
    formatted_date = @date.strftime("%d%m%y").to_i
    string_date = (formatted_date ** 2).to_s
    date_offset = string_date[-4..-1]#need string to get last 4, convert back
  end

  def init_date_offsets
    date_offset = date_calculation
    @a_offset = date_offset[0].to_i
    @b_offset = date_offset[1].to_i
    @c_offset = date_offset[2].to_i
    @d_offset = date_offset[3].to_i
  end

  def key_calculation
    key_a = -(@known[0]) + @unknown[0] + @a_offset
    key_b = -(@known[1]) + @unknown[1] + @b_offset
    key_c = -(@known[2]) + @unknown[2] + @c_offset
    key_d = -(@known[3]) + @unknown[3] + @d_offset
    @key = [key_a, key_b, key_c, key_d]
    # require 'pry'
    # binding.pry
  end

end
# try different keys until you get ..end..? use date
#(-7..-1) for end
#will you have cipher? YES
#given encrypted message
#test different rotations
#wont have same characters, but will have same rotations. Need to find rotations



#can use .rotate instead of %
#run character map, subtract values of ..end..
#subtract dates from that, will get key

# 'a' 'bcde' 'fghi' #find number of rotations between i and . Use to get the key
# '?' '?..h' 'nd..'

# get rotation between ABCD positions
#apply to rest of string
#
#   def crack(output)
#     cipher = Cipher.new
#     @character_list = cipher.characters_to_numbers(output.strip)
#     #group_message_by_letter
#     end_list = [13, 13, 37, 37] #13 13 37 37
#     order_cipher(character_list)
#     compare_last_4_characters(end_list)
#     rotate
#
#
#   end
#
#   def order_cipher(character_list)
#
#
#   end
#
#   def end_list_key(end_list) #get key first,then use decrypt?
#     @a_offset = end_list[0].to_i
#     @b_offset = end_list[1].to_i
#     @c_offset = end_list[2].to_i
#     @d_offset = end_list[3].to_i
#   end
#
#   def group_message_by_letter
#     reset_message_arrays
#     mapper = {0 => @a_message_array, 1 => @b_message_array, 2 => @c_message_array, 3 => @d_message_array}
#     @character_list.each_index do |index|
#         mapper[index % 4] << @character_list[index]
#     end
#   end
#
#   def compare_last_4_characters(end_list) #how do i know which one is abcd
#     last_four = @character_list[-4..-1]
#     @rotations = last_four.zip(end_list).map do |a, b|
#       #(a-b) % 38
#       (b - a) % 38 #character list- 13
#       # require 'pry'
#       # binding.pry
#     end
#   end
#
#   def rotate
#     new_rotations = @character_list.zip(@rotations).map do |a, b|
#       a + b
#     end
#     use_cipher_on_final_rotation(new_rotations)
#   end
#
#   def use_cipher_on_final_rotation(new_rotations) #a is 28, 35, need to modulo 38
#     @character_list = map_encrypted_characters(new_rotations)
#   end
#
#   def map_encrypted_characters(letter_rotation)
#     cipher = Cipher.new
#     cipher.numbers_to_characters(letter_rotation)
#   end
#
# end
#
# crack = Cracker.new
# crack.crack("2yc6")
# puts crack.character_list
# puts crack.rotations
# puts crack.crack("a76uu")

#puts crack.last_four_known
#puts crack.key_a
