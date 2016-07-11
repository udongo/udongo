require 'rails_helper'

describe Backend::FormSubmissionHelper do
  describe '#information_list' do
    let(:submission) { create(:form_submission, form: create(:form)) }
    before(:each) do
      allow(I18n).to receive(:t).with('b.first_name') { 'Voornaam' }
      create(:form_submission_data, submission: submission, name: 'first_name', value: 'John')
    end

    it 'blank config' do
      expect(information_list(submission)).to eq '<ul class="list-unstyled"></ul>'
    end

    it 'name as symbol' do
      allow(Udongo.config).to receive(:form_datagrid_fields) { %w(first_name) }
      expect(information_list(submission)).to eq '<ul class="list-unstyled"><li>Voornaam: John</li></ul>'
    end
  end
end
