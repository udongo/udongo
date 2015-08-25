require 'rails_helper'

describe Redirect do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:source_uri) { expect(build(klass, source_uri: nil)).to_not be_valid }
      it(:destination_uri) { expect(build(klass, destination_uri: nil)).to_not be_valid }
      it(:status_code) { expect(build(klass, status_code: nil)).to_not be_valid }
    end

    describe 'uniqueness' do
      it(:source_uri) do
        create(klass, source_uri: 'foo')
        expect(build(klass, source_uri: 'FOo')).to_not be_valid
      end
    end
  end

  describe '#enabled?' do
    it(:true) { expect(build(klass, disabled: false).enabled?).to be true }
    it(:false) { expect(build(klass, disabled: true).enabled?).to be false }
  end

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

  it '.respond_to?' do
    expect(model).to respond_to(:disabled, :enabled)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:enabled?)
  end
end
