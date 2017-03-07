require 'rails_helper'

describe Udongo::Configs::Tags do
  let(:klass) { described_class }
  let(:instance) { klass.new }

  describe 'defaults' do
    it :allow_new do
      expect(klass.new.allow_new).to eq true
    end
  end

  describe '#allow_new?' do
    it :false do
      instance.allow_new = false
      expect(instance).not_to be_allow_new
    end

    it :true do
      instance.allow_new = true
      expect(instance).to be_allow_new
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(:allow_new, :allow_new=, :allow_new?)
  end
end
