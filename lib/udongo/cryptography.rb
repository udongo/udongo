module Udongo::Cryptography
  def crypt(options = {})
    @crypt ||= Udongo::Crypt.new(options)
  end
end
