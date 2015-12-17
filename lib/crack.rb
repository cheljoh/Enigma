require_relative 'cracker'
require_relative 'cipher'
require 'date'

crypt = Cracker.new(Date.strptime(ARGV[2], '%d%m%y'))
encrypted = File.read(ARGV[0])
cracked = crypt.crack(encrypted)
File.write(ARGV[1], cracked) #ARGV[1] = location

known_phrase = "nd.."
cipher = Cipher.new
last_four_unknown = cipher.characters_to_numbers(encrypted[-4..-1])
last_four_known = cipher.characters_to_numbers(known_phrase[-4..-1])
known = crypt.order_list(encrypted, last_four_known)
unknown = crypt.order_list(encrypted, last_four_unknown)
crypt.init_date_offsets
base_key = crypt.get_base_key(known, unknown)
candidates = crypt.key_candidates(base_key)
valid_key = crypt.test_keys(encrypted, known_phrase, candidates)

puts "Created " "#{ARGV[1]}" " with the cracked key " "#{valid_key}" " and date " "#{crypt.date.strftime("%d%m%y")}"
