require 'rails_helper'

describe FormDecorator do
  let(:instance) { create(:form).decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }

  describe '#email_present?' do
    let(:submission) { create(:form_submission) }

    it 'true' do
      create(:form_submission_data, submission: submission, name: 'email')
      allow(instance.object).to receive(:submissions) { [submission] }
      expect(instance.email_present?).to be true
    end

    it 'false' do
      create(:form_submission_data, submission: submission, name: 'foo')
      allow(instance.object).to receive(:submissions) { [submission] }
      expect(instance.email_present?).to be false
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :email_present?
    )
  end
end
