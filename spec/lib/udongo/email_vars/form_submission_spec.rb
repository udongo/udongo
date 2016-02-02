require 'rails_helper'

describe Udongo::EmailVars::FormSubmission do
  let(:form_submission) { create(:form_submission) }
  let(:instance) { described_class.new(form_submission) }

  describe '#to_hash' do
    it 'blank' do
      expect(instance.to_hash).to eq({})
    end

    it 'has values' do
      form_submission.data.create!(name: 'first_name', value: 'John')
      form_submission.data.create!(name: 'last_name', value: 'Beton')
      expect(instance.to_hash).to eq('submission.first_name': 'John', 'submission.last_name': 'Beton')
    end

    it 'custom prefix' do
      form_submission.data.create!(name: 'first_name', value: 'John')
      form_submission.data.create!(name: 'last_name', value: 'Beton')
      expect(instance.to_hash(prefix: 'a')).to eq('a.first_name': 'John', 'a.last_name': 'Beton')
    end
  end

  it '#respond_to' do
    expect(instance).to respond_to(:to_hash)
  end
end
