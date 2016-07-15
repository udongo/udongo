require 'rails_helper'

describe Backend::FormSubmissionHelper do
  describe '#datagrid_column_values' do
    let(:form) { create(:form, identifier: 'foo') }
    let(:submission) { create(:form_submission, form: form) }

    before(:each) do
      allow(I18n).to receive(:t).with('b.first_name') { 'Voornaam' }
      create(:form_submission_data, submission: submission, name: 'first_name', value: 'John')
    end

    it 'blank config' do
      expect(datagrid_column_values(form, submission)).to eq nil
    end

    it 'name as symbol' do
      allow(Udongo.config).to receive(:form_datagrid_fields) { { foo: %w(first_name) } }
      expect(datagrid_column_values(form, submission)).to eq '<td>John</td>'
    end
  end

  it '#responds_to?' do
    expect(self).to respond_to(
      :datagrid_column_values, :datagrid_column_headers
    )
  end
end
