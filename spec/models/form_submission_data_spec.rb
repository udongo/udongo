require 'rails_helper'

describe FormSubmissionData do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:submission) { expect(build(klass, submission: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:submission)
  end
end
