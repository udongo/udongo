require 'rails_helper'

describe Udongo::Notification do
  let(:instance) { described_class.new }
  before(:each) do
    I18n.locale = :nl
  end

  describe '#translate_notice' do
    it 'with 1 actor' do
      allow(I18n).to receive(:t).with('b.foo') { 'Foo' }
      allow(I18n).to receive(:t).with("b.msg.added", actor: 'Foo') { 'Foo werd toegevoegd' }
      expect(instance.translate_notice(:added, :foo)).to eq 'Foo werd toegevoegd'
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :translate_notice
    )
  end
end
