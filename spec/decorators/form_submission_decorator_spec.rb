require 'rails_helper'

describe FormSubmissionDecorator do
  let(:instance) { create(:form_submission).decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }
end
