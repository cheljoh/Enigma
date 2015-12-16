require_relative 'cracker'
require 'Date'

crypt = Crack.new(Date.strptime(ARGV[2], '%d%m%y'))
encrypted = File.read(ARGV[0])
cracked = crypt.crack(encrypted)
File.write(ARGV[1], cracked) #ARGV[1] = location
puts "Created " "#{ARGV[1]}" " with the cracked key " "#{crypt.key}" " and date " "#{crypt.date.strftime("%d%m%y")}"
