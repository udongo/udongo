require 'rails_helper'

describe Udongo::Configs::FlexibleContent do
  let(:klass) { described_class }
  let(:instance) { described_class.new }

  describe 'defaults' do
    it :BREAKPOINTS do
      expect(klass::BREAKPOINTS).to eq %w(xs sm md lg xl)
    end

    it :types do
      expect(instance.types).to eq %w(text picture image)
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :types, :types=
    )
  end
end
