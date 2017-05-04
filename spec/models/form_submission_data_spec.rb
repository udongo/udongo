require 'rails_helper'

describe FormSubmissionData do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:form_submission) { expect(build(klass, form_submission: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form_submission)
  end
end
