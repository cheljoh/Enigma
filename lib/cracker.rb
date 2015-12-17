require_relative 'cryptographer'
require_relative 'cipher'

class Cracker

  attr_reader :date

  def initialize (date = Time.now)
    @date = date
  end

  def crack(output)
    known_phrase = "nd.."
    cipher = Cipher.new
    last_four_unknown = cipher.characters_to_numbers(output[-4..-1])
    last_four_known = cipher.characters_to_numbers(known_phrase[-4..-1])
    known = order_list(output, last_four_known)
    unknown = order_list(output, last_four_unknown)
    init_date_offsets
    base_key = get_base_key(known, unknown)
    candidates = key_candidates(base_key)
    valid_key = test_keys(output, known_phrase, candidates)
    decrypt_message_using_key(output, valid_key)
  end

  def test_keys(output, known_phrase, candidates)
    valid_key = ""
    for a in candidates[0]
      for b in candidates[1]
        for c in candidates[2]
          for d in candidates[3]
            key = a[0] + b[0] + c[0] + d
            decrypted = decrypt_message_using_key(output, key)
            if decrypted[-4..-1] == known_phrase[-4..-1]
              valid_key = key
              break
            end
          end
        end
      end
    end
    valid_key
  end

  def decrypt_message_using_key(output, key)
    crack_message = Cryptographer.new(key)
    crack_message.decrypt(output)
  end

  def order_list(output, list) #use rotation
    if output.length % 4 == 0
       list
    elsif output.length % 4 == 1
      list.rotate(3)
    elsif output.length % 4 == 2
      list.rotate(2)
    elsif output.length % 4 == 3
      list.rotate(1)
    end
  end

  def date_calculation
    formatted_date = @date.strftime("%d%m%y").to_i
    string_date = (formatted_date ** 2).to_s
    string_date[-4..-1]
  end

  def init_date_offsets
    date_offset = date_calculation
    @a_offset = date_offset[0].to_i
    @b_offset = date_offset[1].to_i
    @c_offset = date_offset[2].to_i
    @d_offset = date_offset[3].to_i
  end

  def get_base_key(known, unknown)
    key_a = -(known[0]) + unknown[0] - @a_offset
    key_b = -(known[1]) + unknown[1] - @b_offset
    key_c = -(known[2]) + unknown[2] - @c_offset
    key_d = -(known[3]) + unknown[3] - @d_offset
    [key_a, key_b, key_c, key_d]
  end

  def key_candidates(base_key)
    candidates = []
    for value in base_key
      candidates << sub_key_candidates(value)
    end
    candidates
  end

  def sub_key_candidates(starting_value)
    candidates = []
    while starting_value < 100
      if starting_value >= 0
        candidates <<  "%02d" % starting_value #give 0-9 a leading 0. i.e. 00, 01, 02, 03
      end
      starting_value += 38
    end
    candidates
  end

end
