require 'rails_helper'

describe FormSubmissionDataDecorator do
  let(:form_submission_data) { create(:form_submission_data) }
  let(:instance) { form_submission_data.decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }

  describe '#label' do
    it 'defaults to name' do
      form_submission_data.name = 'email'
      expect(instance.label).to eq 'email'
    end

    it 'uses field#label when present' do
      I18n.with_locale(:nl) do
        form = create(:form)
        field = create(:form_field, form: form, identifier: 'email')
        translation = field.translation
        translation.label = 'E-mailadres'
        translation.save
        submission = create(:form_submission, form: form)
        data = create(:form_submission_data, form_submission: submission, name: 'email', value: 'dave@blimp.be')

        expect(data.decorate.label).to eq 'E-mailadres'
      end
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(:label)
  end
end
