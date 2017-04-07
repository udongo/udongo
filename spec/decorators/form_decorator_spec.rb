require 'rails_helper'

describe FormDecorator do
  let(:form) { create(:form, identifier: 'foo') }
  let(:instance) { form.decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }

  it '#datagrid' do
    expect(instance.datagrid).to be_instance_of Udongo::Forms::SubmissionDatagrid
  end

  describe '#datagrid_fields_configured?' do
    it 'true' do
      allow(Udongo.config.forms).to receive(:foo) { OpenStruct.new(datagrid_fields: %w(email)) }
      expect(instance.datagrid_fields_configured?).to be true
    end

    it 'false' do
      expect(instance.datagrid_fields_configured?).to be false
    end
  end

  describe '#email_present?' do
    let(:submission) { create(:form_submission, form: form) }

    before(:each) do
      allow(instance).to receive(:datagrid_fields_configured?) { false }
    end

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
        allow(instance).to receive(:datagrid_fields_configured?) { true }
        expect(instance.email_present?).to be false
      end
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :datagrid, :datagrid_fields_configured?, :email_present?
    )
  end
end
