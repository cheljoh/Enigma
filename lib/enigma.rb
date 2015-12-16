require_relative 'cryptographer'
require_relative 'cracker'
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

  def crack(output, date = Time.now)
    crack_message = Cracker.new(date)
    crack_message.crack(output)
  end

end

encrypt = Enigma.new
puts encrypt.encrypt("hello ..end..", 15654)
puts encrypt.decrypt("2yc69s2uz76uu", 15654)
puts encrypt.crack("2yc69s2uz76uu")
