require_relative 'cryptographer'

crypt = Cryptographer.new
unencrypted = File.read(ARGV[0])
encrypted = crypt.encrypt(unencrypted)
File.write(ARGV[1], encrypted) #ARGV[1] = location
puts "Created " "#{ARGV[1]}" " with the key " "#{crypt.key}" " and date " "#{crypt.date.strftime("%d%m%y")}"
