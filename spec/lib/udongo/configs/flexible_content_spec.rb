require 'rails_helper'

describe Udongo::Configs::FlexibleContent do
  let(:klass) { described_class }
  let(:instance) { described_class.new }

  describe 'defaults' do
    it :breakpoints do
      expect(instance.breakpoints).to eq %w(xs sm md lg xl)
    end

    it :allowed_breakpoints do
      expect(instance.allowed_breakpoints).to eq %w(xs sm md lg xl)
    end

    it :types do
      expect(instance.types).to eq %w(text image)
    end
  end

  describe '#allowed_breakpoint?' do
    it 'true' do
      allow(instance).to receive(:allowed_breakpoints) { %w(xs sm md lg xl) }
      expect(instance.allowed_breakpoint?(:sm)).to be true
    end

    it 'false' do
      allow(instance).to receive(:allowed_breakpoints) { %w(xs) }
      expect(instance.allowed_breakpoint?(:sm)).to be false
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :types, :types=, :allowed_breakpoints, :allowed_breakpoints=,
      :allowed_breakpoint?
    )
  end
end
