require 'rails_helper'
require 'udongo/forms/submission_datagrid'

describe Udongo::Forms::SubmissionDatagrid do
  let(:form) { create(:form, identifier: 'foo') }
  let(:submission) { create(:form_submission, form: form) }
  let(:instance) { described_class.new(form) }

  before(:each) do
    allow(Udongo.config.forms).to receive(:foo) do
      OpenStruct.new(datagrid_fields: [:foo, :bar], filter_fields: [:foo])
    end
  end

  describe '#fields' do
    it 'no config' do
      form.update_attribute(:identifier, 'bar')
      expect(instance.fields).to eq []
    end

    it 'with fields defined in config' do
      expect(instance.fields).to eq [:foo, :bar]
    end
  end

  context 'a first name column' do
    let(:filter) { OpenStruct.new } # TODO: If we need filter.

      before(:each) do
      allow(I18n).to receive(:t).with('b.first_name') { 'Voornaam' }
      create(:form_submission_data, form_submission: submission, name: 'first_name', value: 'John')
      allow(instance).to receive(:fields) { %w(first_name) }
    end

    it '#column_headers' do
      expect(instance.column_headers).to eq '<th>Voornaam</th>'
    end

    it '#column_values' do
      expect(instance.column_values(submission)).to eq '<td>John</td>'
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(:column_headers, :column_values)
  end
end
