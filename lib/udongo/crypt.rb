class Udongo::Crypt
  attr_reader :options

  def initialize(options = {})
    @options = options.reverse_merge!(secret: Rails.configuration.secret_key_base)
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
