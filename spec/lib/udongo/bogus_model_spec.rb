require 'rails_helper'

describe Udongo::BogusModel do
  let(:instance) { described_class.new }

  it '.base_class' do
    expect(described_class.base_class).to eq Class
  end

  describe '#id' do
    it 'gives a random int > 0' do
      expect(instance.id).to satisfy { |e| e > 0 }
    end

    it 'always returns the same value on multiple calls' do
      id = instance.id
      expect(instance.id).to eq id
      expect(instance.id).to eq id
      expect(instance.id).to eq id
    end
  end

  it '#new_record?' do
    expect(instance.new_record?).to be false
  end

  it '#destroyed?' do
    expect(instance.destroyed?).to be false
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :_read_attribute, :id, :destroyed?, :new_record?
    )
  end

  it '.responds_to?' do
    expect(described_class).to respond_to(:base_class, :primary_key)
  end
end
