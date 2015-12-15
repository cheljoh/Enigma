#require_relative 'cryptographer'
require_relative 'cipher'
require 'date'

class Crack

  attr_reader :rotations, :character_list

  def initialize (date = Date.today)
    @date = date
    @a_message_array = []
    @b_message_array = []
    @c_message_array = []
    @d_message_array = []
  end

  #cant you use key and then do decrypt class?????


  def get_key(output)
    cipher = Cipher.new
    @character_list = cipher.characters_to_numbers(output.strip)
    end_list = cipher.characters_to_numbers("nd..")
    group_message_by_letter #need just last four
    end_list_key(end_list)
    date_calculation
    init_date_offsets
    key_calculation
  end

  def date_calculation
    formatted_date = @date.strftime("%d%m%y").to_i
    string_date = (formatted_date ** 2).to_s
    date_offset = string_date[-4..-1] #need string to get last 4, convert back
  end

  def init_date_offsets
    date_offset = date_calculation
    @a_offset = date_offset[0].to_i
    @b_offset = date_offset[1].to_i
    @c_offset = date_offset[2].to_i
    @d_offset = date_offset[3].to_i
  end

  def key_calculation
    key_a = @a_message_array
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

  # def crack(output)
  #   cipher = Cipher.new
  #   @character_list = cipher.characters_to_numbers(output.strip)
  #   #group_message_by_letter
  #   end_list = cipher.characters_to_numbers("nd..")
  #   compare_last_4_characters(end_list)
  #   rotate
  #
  #
  # end

  def end_list_key(end_list)
    @a_offset = end_list[0].to_i
    @b_offset = end_list[1].to_i
    @c_offset = end_list[2].to_i
    @d_offset = end_list[3].to_i
  end

  def group_message_by_letter
    reset_message_arrays
    mapper = {0 => @a_message_array, 1 => @b_message_array, 2 => @c_message_array, 3 => @d_message_array}
    @character_list.each_index do |index|
        mapper[index % 4] << @character_list[index]
    end
  end

  def compare_last_4_characters(end_list) #how do i know which one is abcd
    last_four = @character_list[-4..-1]
    @rotations = last_four.zip(end_list).map do |a, b|
      (b - a) % 38
    end
  end

  def rotate
    new_rotations = @character_list.zip(@rotations).map do |a, b|
      a + b
    end
    use_cipher_on_final_rotation(new_rotations)
  end

  def use_cipher_on_final_rotation(new_rotations) #a is 28, 35, need to modulo 38
    @character_list = map_encrypted_characters(new_rotations)
  end

  def map_encrypted_characters(letter_rotation)
    cipher = Cipher.new
    cipher.numbers_to_characters(letter_rotation)
  end

end

crack = Crack.new
# crack.crack("2yc6")
# puts crack.character_list
puts crack.get_key("2yc6")
