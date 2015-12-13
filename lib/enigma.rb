require_relative 'cryptographer'
require 'Date'

class Enigma

  def encrypt(message, key = rand.to_s[2..6], date = Time.now)
    crypt = Cryptographer.new(key, date)
    crypt.encrypt(message)
  end

  def decrypt(output, key = rand.to_s[2..6], date = Time.now)
    crypt = Cryptographer.new(key, date)
    crypt.decrypt(output)
  end

end

enigma = Enigma.new
output = enigma.encrypt("this is so secret ..end..", 15654, Date.today)
puts output
puts enigma.decrypt(output, 15654, Date.today)
