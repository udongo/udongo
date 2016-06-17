require 'rails_helper'

describe Udongo::Notification do
  let(:instance) { described_class.new(:added) }
  before(:each) do
    I18n.locale = :nl
  end

  it '#label' do
    expect(instance.label).to eq 'b.msg.added'
  end

  it '#build_hash' do
    allow(I18n).to receive(:t).with('b.fubar') { 'Foo' }
    expect(instance.build_hash(:fubar)).to eq({ actor: 'Foo' })
  end

  describe '#translate' do
    it 'without params' do
      allow(I18n).to receive(:t).with('b.msg.added') { 'Dit is een melding zonder vars' }
      expect(instance.translate).to eq 'Dit is een melding zonder vars'
    end

    it '"old" syntax with 1 actor' do
      allow(I18n).to receive(:t).with('b.foo') { 'Foo' }
      allow(I18n).to receive(:t).with("b.msg.added", actor: 'Foo') { 'Foo werd toegevoegd' }
      expect(instance.translate(:foo)).to eq 'Foo werd toegevoegd'
    end

    it 'multiple vars' do
      allow(I18n).to receive(:t).with("b.msg.added", foo: 'bar', total: 30) { '30 foos in bar' }
      expect(instance.translate(foo: 'bar', total: 30)).to eq '30 foos in bar'
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :build_hash, :label, :translate
    )
  end
end
