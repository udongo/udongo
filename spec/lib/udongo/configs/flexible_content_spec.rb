require 'rails_helper'

describe Udongo::Configs::FlexibleContent do
  let(:klass) { described_class }

  describe 'defaults' do
    it :types do
      expect(klass.new.types).to eq %w(text image)
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(:types, :types=)
  end
end
