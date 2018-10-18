require 'rails_helper'

describe Redirect do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:source_uri) { expect(build(klass, source_uri: nil)).not_to be_valid }
      it(:destination_uri) { expect(build(klass, destination_uri: nil)).not_to be_valid }
      it(:status_code) { expect(build(klass, status_code: nil)).not_to be_valid }
    end

    describe 'uniqueness' do
      it :source_uri do
        create(klass, source_uri: 'foo')
        expect(build(klass, source_uri: 'FOo')).not_to be_valid
      end
    end
  end

  describe '#enabled?' do
    it(:true) { expect(build(klass, disabled: false)).to be_enabled }
    it(:false) { expect(build(klass, disabled: true)).not_to be_enabled }
  end

  it '#used!' do
    redirect = build(klass)
    redirect.used!

    expect(redirect.times_used).to eq 1
  end

  describe 'scopes' do
    describe '.enabled' do
      it :default do
        expect(model.enabled).to eq []
      end

      it :result do
        redirect = create(klass, disabled: false)
        expect(model.enabled).to eq [redirect]
      end
    end

    describe '.disabled' do
      it :default do
        expect(model.disabled).to eq []
      end

      it :result do
        redirect = create(klass, disabled: true)
        expect(model.disabled).to eq [redirect]
      end
    end
  end

  describe '#works?' do
    subject { create(:redirect, source_uri: '/nl/foo', destination_uri: '/nl/bar') }

    it 'returns false when the curl response does not indicate a redirect' do
      allow_any_instance_of(Udongo::Redirects::Test).to receive(:perform!) do
        double(:response, last_effective_url: 'http://udongo.test/nl/foo')
      end

      expect(subject.works?(base_url: 'http://udongo.test')).to be false
    end

    it 'returns true when the curl response indicates our redirect succeeded' do
      allow_any_instance_of(Udongo::Redirects::Test).to receive(:perform!) do
        double(:response, last_effective_url: 'http://udongo.test/nl/bar')
      end
      expect(subject.works?(base_url: 'http://udongo.test')).to be true
    end
  end

  it '.respond_to?' do
    expect(model).to respond_to(:disabled, :enabled)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:enabled?, :used!)
  end
end
