require_relative 'cryptographer'
require 'Date'

crypt = Cryptographer.new(ARGV[2], Date.strptime(ARGV[3], '%d%m%y')) 
encrypted = File.read(ARGV[0])
decrypted = crypt.decrypt(encrypted)
File.write(ARGV[1], decrypted) #ARGV[1] = location
puts "Created " "#{ARGV[1]}" " with the key " "#{crypt.key}" " and date " "#{crypt.date.strftime("%d%m%y")}"
