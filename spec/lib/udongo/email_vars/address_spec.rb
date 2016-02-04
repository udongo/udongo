require 'rails_helper'

describe Udongo::EmailVars::Address do
  let(:klass) { described_class }

  describe '#to_hash' do
    it 'no values' do
      address = create(
        :address,
        street: nil,
        number: nil,
        postal: nil,
        city: nil,
        country: nil
      )

      expect(address.email_vars.to_hash).to eq({
        'address.street': nil,
        'address.number': nil,
        'address.postal': nil,
        'address.city': nil,
        'address.country': nil
      })
    end

    it 'has values' do
      address = create(
        :address,
        street: 'Foostreet',
        number: 588,
        postal: 9000,
        city: 'Gent',
        country: 'Belgium'
      )

      expect(address.email_vars.to_hash).to eq({
        'address.street': 'Foostreet',
        'address.number': '588',
        'address.postal': '9000',
        'address.city': 'Gent',
        'address.country': 'Belgium'
      })
    end

    it 'custom prefix' do
      address = create(
        :address,
        street: 'Foostreet',
        number: 588,
        postal: 9000,
        city: 'Gent',
        country: 'Belgium'
      )

      expect(address.email_vars.to_hash(prefix: 'foo')).to eq({
        'foo.street': 'Foostreet',
        'foo.number': '588',
        'foo.postal': '9000',
        'foo.city': 'Gent',
        'foo.country': 'Belgium'
      })
    end
  end

  it '#respond_to' do
    expect(klass.new(create(:address))).to respond_to(:to_hash)
  end
end
