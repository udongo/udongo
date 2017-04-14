require 'rails_helper'

describe FormDecorator do
  let(:form) { create(:form, identifier: 'foo') }
  let(:instance) { form.decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }

  describe '#email_present?' do
    let(:submission) { create(:form_submission, form: form) }

    it 'true' do
      create(:form_submission_data, form_submission: submission, name: 'email')
      allow(instance.object).to receive(:submissions) { [submission] }
      expect(instance.email_present?).to be true
    end

    describe 'false' do
      it 'no email column in submission data' do
        create(:form_submission_data, form_submission: submission, name: 'foo')
        allow(instance.object).to receive(:submissions) { [submission] }
        expect(instance.email_present?).to be false
      end

      it 'specific datagrid_fields config present' do
        expect(instance.email_present?).to be false
      end
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :email_present?
    )
  end
end
