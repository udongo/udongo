require 'rails_helper'

shared_examples_for :visible do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'scopes' do
    it :visible do
      a = create(klass, visible: true)
      b = create(klass, visible: false)
      expect(model.visible).to eq [a]
    end

    it :hidden do
      a = create(klass, visible: true)
      b = create(klass, visible: false)
      expect(model.hidden).to eq [b]
    end
  end

  context 'hidden' do
    let(:item) { build(klass, visible: false) }

    it '#hidden?' do
      expect(item.hidden?).to be true
    end

    it '#hide!' do
      item.hide!
      expect(item.hidden?).to be true
    end

    it '#show!' do
      item.show!
      expect(item.visible?).to be true
    end
  end

  context 'visible' do
    let(:item) { build(klass, visible: true) }

    it '#hidden?' do
      expect(item.hidden?).to be false
    end

    it '#hide!' do
      item.hide!
      expect(item.hidden?).to be true
    end

    it '#show!' do
      item.show!
      expect(item.visible).to be true
    end
  end

  it '.respond_to?' do
    expect(model).to respond_to(:visible, :hidden)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:hidden?, :hide!, :show!)
  end
end
