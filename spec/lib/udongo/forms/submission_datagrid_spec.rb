require 'rails_helper'
require 'udongo/forms/submission_datagrid'

describe Udongo::Forms::SubmissionDatagrid do
  let(:form) { create(:form, identifier: 'foo') }
  let(:submission) { create(:form_submission, form: form) }
  let(:instance) { described_class.new(form) }

  before(:each) do
    allow(Udongo.config).to receive(:form_submissions) do
      { foo: { datagrid_fields: [:foo, :bar], filter: [:foo] } }
    end
  end

  describe '#config' do
    it 'with matching form identifier' do
      expect(instance.config).to eq({ datagrid_fields: [:foo, :bar], filter: [:foo] })
    end

    it 'without matching form identifier' do
      form.update_attribute(:identifier, 'bar')
      expect(instance.config).to be nil
    end
  end

  describe '#fields' do
    it 'no config' do
      form.update_attribute(:identifier, 'bar')
      expect(instance.fields).to eq []
    end

    it 'with fields defined in config' do
      allow(instance).to receive(:config) { { datagrid_fields: [:foo, :bar] } }
      expect(instance.fields).to eq [:foo, :bar]
    end
  end

  context 'a first name column' do
    let(:filter) { OpenStruct.new } # TODO: If we need filter.

    before(:each) do
      allow(I18n).to receive(:t).with('b.first_name') { 'Voornaam' }
      create(:form_submission_data, submission: submission, name: 'first_name', value: 'John')
      allow(instance).to receive(:fields) { %w(first_name) }
    end

    it '#column_headers' do
      expect(instance.column_headers(filter)).to eq '<th>Voornaam</th>'
    end

    it '#column_values' do
      expect(instance.column_values(submission)).to eq '<td>John</td>'
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :column_headers, :column_values
    )
  end
end