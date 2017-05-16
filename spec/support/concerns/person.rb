require 'rails_helper'

shared_examples_for :person do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it :full_name do
    person = build(klass, first_name: 'Foo', last_name: 'Bar')
    expect(person.full_name).to eq 'Foo Bar'
  end

  describe '#short_name' do
    it 'no first name' do
      person = build(klass, first_name: nil, last_name: 'Bar')
      expect(person.short_name).to eq 'B.'
    end

    it 'no last name' do
      person = build(klass, first_name: 'Foo', last_name: nil)
      expect(person.short_name).to eq 'Foo'
    end

    it 'last name with 1 word' do
      person = build(klass, first_name: 'Foo', last_name: 'Bar')
      expect(person.short_name).to eq 'Foo B.'
    end

    it 'last name with 2 words' do
      person = build(klass, first_name: 'Foo', last_name: 'Bar Baz')
      expect(person.short_name).to eq 'Foo B.B.'
    end

    it 'last name with 3 words' do
      person = build(klass, first_name: 'Foo', last_name: 'Bar Baz Boz')
      expect(person.short_name).to eq 'Foo B.B.B.'
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:full_name, :short_name)
  end
end
