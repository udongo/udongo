require 'rails_helper'

describe Udongo::Configs::Tags do
  let(:klass) { described_class }

  describe 'defaults' do
    it :allow_new do
      expect(klass.new.allow_new).to eq true
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(:allow_new, :allow_new=, :allow_new?)
  end
end
