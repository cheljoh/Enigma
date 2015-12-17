

class Cipher

  def cipher
    {'a' => 0,  'b' => 1,  'c' => 2,  'd' => 3,
     'e' => 4,  'f' => 5,  'g' => 6,  'h' => 7,
     'i' => 8,  'j' => 9,  'k' => 10, 'l' => 11,
     'm' => 12, 'n' => 13, 'o' => 14, 'p' => 15,
     'q' => 16, 'r' => 17, 's' => 18, 't' => 19,
     'u' => 20, 'v' => 21, 'w' => 22, 'x' => 23,
     'y' => 24, 'z' => 25, '0' => 26, '1' => 27,
     '2' => 28, '3' => 29, '4' => 30, '5' => 31,
     '6' => 32, '7' => 33, '8' => 34, '9' => 35,
     " " => 36, "." => 37, "," => 38}
  end

  def character_to_number(character)
    cipher[character]
  end

  def characters_to_numbers(message)
    array = message.split("").map do |character|
      character_to_number(character)
    end
    array
  end

  def number_to_character(character)
    corrected_number = character % 38
    cipher.key(corrected_number)
  end

  def numbers_to_characters(numbers)
    array = numbers.map do |number|
      number_to_character(number)
    end
    array
  end

end
