require 'rails_helper'

describe Setting do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:name) { expect(build(klass, name: nil)).not_to be_valid }
    end

    it :unique do
      create(klass, name: 'foo')
      expect(build(klass, name: 'FOO')).not_to be_valid
    end
  end

  it 'expects value to allow all kinds of objects' do
    expect(model.new(value: 'foo').value).to eq('foo')
    expect(model.new(value: [1, 2, 3]).value).to eq([1, 2, 3])
    expect(model.new(value: { a: 'b' }).value).to eq({ a: 'b' })
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:value, :value=)
  end
end

