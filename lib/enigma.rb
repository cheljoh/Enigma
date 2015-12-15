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

encrypt = Enigma.new
puts encrypt.encrypt("hellosi", 15654)
puts encrypt.decrypt("2yc69a.", 15654)
