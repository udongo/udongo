class Udongo::Crypt
  attr_reader :options

  def initialize(secret: Rails.configuration.secret_key_base)
    @options = { secret: secret }
  end

  def crypt
    @crypt ||= ActiveSupport::MessageEncryptor.new(options[:secret])
  end

  def encrypt(value)
    crypt.encrypt_and_sign(value)
  end

  def decrypt(value)
    crypt.decrypt_and_verify(value)
  end
end
