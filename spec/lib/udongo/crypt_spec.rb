require 'rails_helper'

describe Udongo::Crypt do
  let(:instance) { described_class.new }
  before(:each) do
    allow(Rails.configuration).to receive(:secret_key_base) { '546a52fb64c2d25f879ad060715d936d7bf253aaa4bdee1ca22afb0692cf4fcf939b4b4c744353c71b528dd3c7faf141e6f630c7aa3ec00c93032fb04489315d' }
  end

  describe 'secret' do
    it 'default' do
      expect(instance.options[:secret]).to eq '546a52fb64c2d25f879ad060715d936d7bf253aaa4bdee1ca22afb0692cf4fcf939b4b4c744353c71b528dd3c7faf141e6f630c7aa3ec00c93032fb04489315d'
    end

    it 'can be passed through construct' do
      instance = described_class.new(secret: 'blub')
      expect(instance.options[:secret]).to eq 'blub'
    end
  end

  it '#crypt' do
    expect(instance.crypt).to be_instance_of ActiveSupport::MessageEncryptor
  end

  it '#encrypt' do
    # Every encrypted string is also signed, so it's different every time.
    # We can't but check the resulting size, which is always 110.
    expect(instance.encrypt('foo').size).to eq 110
  end

  it '#decrypt' do
    encrypted_value = instance.encrypt('foo')
    expect(instance.decrypt(encrypted_value)).to eq 'foo'
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:crypt, :encrypt, :decrypt, :options)
  end
end
